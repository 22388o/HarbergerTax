// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

/******
 * @title Harberger Tax Contract
 * @author Tirtha Sarker
 * @notice The contract will manage the slot purchase system and forward taxes
 */

contract HarbergerTax {
    uint256 public constant DURATION = 7 days; // Value Q measured in days
    uint256 public constant HARBERGER_HIKE = 20; // Harberger Hike (HH)
    uint256 public constant HARBERGER_TAX = 10; //  Harberger Tax (HT)
    uint256 public constant INITIAL_PRICE = 100000; // Initial Price (IP) in wei

    string public slotV = ""; // single variable V
    uint256 public currentPrice;
    uint256 public expirationTime;
    address public currentOwner;
    address public issuer;

    /*******************
     *   EVENTS
     *******************/

    /**
     * @notice Emits when new buyer purchases slot
     * @param _owner address of new buyer
     * @param _price the new price settled by buyer
     * @param _expiration the time uptil which the slot is owned by buyer
     */
    event SlotPurchased(
        address indexed _owner,
        uint256 indexed _price,
        uint256 indexed _expiration
    );

    /**
     * @notice Emits when buyer extends duration of slot ownership
     * @param _owner address of buyer
     * @param _newExpiration the new time uptil which the slot is owned by buyer
     */
    event SlotExpirationExtended(
        address indexed _owner,
        uint256 indexed _newExpiration
    );

    /**
     * @notice Emits when owner updates the slot content
     * @param _owner address of buyer
     * @param _time the time when content were updated
     */
    event SlotUpdated(address indexed _owner, uint256 indexed _time);

    /***************
     * CONSTRUCTOR
     ***************/
    constructor() {
        issuer = msg.sender;
        currentOwner = issuer;
        currentPrice = INITIAL_PRICE;
    }

    /**
     * @notice Called with value to buy the slot
     * @param newPrice the suggested price by the buyer
     */
    function buySlot(uint256 newPrice) external payable returns (bool) {
        /**************For 1st issuance***********/

        if (currentOwner == issuer) {
            require(
                newPrice >= currentPrice,
                "NEW_PRICE_NOT_HIGHER_OR_EQUAL_TO_INITIAL"
            ); //  P >= IP
            require(
                msg.value >= newPrice + ((newPrice * HARBERGER_TAX) / 100),
                "SUFFICIENT_PAYMENT_NOT_MADE"
            ); //P + (P*HT)

            currentOwner = msg.sender;
            currentPrice = newPrice;
            expirationTime = block.timestamp + DURATION;
            (bool success1, ) = issuer.call{value: msg.value}("");
            require(success1, "TRANSACTION_FAILED");

            emit SlotPurchased(currentOwner, currentPrice, expirationTime);

            return true;
        }

        /************* Check Slot Expiration ****************/
        checkExpirationStatus();

        /************* Extend Existing Issuance ****************/

        if (currentOwner == msg.sender) {
            require(
                DURATION >= (expirationTime - block.timestamp),
                "ONLY_ONE_PERIOD_CAN_BE_BOOKED_IN_ADVANCE"
            );
            require(
                msg.value >= ((newPrice * HARBERGER_TAX) / 100),
                "SUFFICIENT_PAYMENT_NOT_MADE"
            );
            expirationTime += DURATION;

            (bool success2, ) = issuer.call{value: msg.value}("");
            require(success2, "TRANSACTION_FAILED");
            emit SlotExpirationExtended(currentOwner, expirationTime);
            return true;
        }

        /************* New Buyer ****************/
        require(
            newPrice >= currentPrice + ((currentPrice * HARBERGER_HIKE) / 100),
            "NEW_PRICE_NOT_SUFFICIENT"
        ); //P1 >= P + P*HH

        uint256 taxAmount = (newPrice * HARBERGER_TAX) / 100;

        require(
            msg.value >=
                (newPrice + taxAmount + ((newPrice * HARBERGER_HIKE) / 100)),
            "SUFFICIENT_VALUE_NOT_TRANSFERRED"
        );
        address previousOwner = currentOwner;
        currentOwner = msg.sender;
        currentPrice = newPrice;
        expirationTime = block.timestamp + DURATION;

        (bool success3, ) = issuer.call{value: taxAmount}(""); // P1*HT
        require(success3, "TAX_AMOUNT_TRANSFERR_FAILED");
        (bool success4, ) = previousOwner.call{value: (msg.value - taxAmount)}(
            ""
        );
        require(success4, "PREVIOUS_OWNER_AMOUNT_TRANSFER_FAILED");

        emit SlotPurchased(currentOwner, currentPrice, expirationTime);
        return true;
    }

    /**
     * @notice Called to update the slot content
     * @param newValue the new content string
     */

    function updateSlot(string memory newValue) external {
        checkExpirationStatus();
        require(msg.sender == currentOwner, "ONLY_OWNER_CAN_UPDATE");

        slotV = newValue;

        emit SlotUpdated(msg.sender, block.timestamp);
    }

    /**
     * @notice Internally called to check slot expiration
     */
    function checkExpirationStatus() internal {
        if (expirationTime < block.timestamp) {
            currentOwner = issuer;
            currentPrice = INITIAL_PRICE;
        }
    }
}
