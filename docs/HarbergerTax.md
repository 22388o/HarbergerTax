# HarbergerTax





## Contents
<!-- START doctoc -->
<!-- END doctoc -->

## Globals

> Note this contains internal vars as well due to a bug in the docgen procedure

| Var | Type |
| --- | --- |
| DURATION | uint256 |
| HARBERGER_HIKE | uint256 |
| HARBERGER_TAX | uint256 |
| INITIAL_PRICE | uint256 |
| slotV | string |
| currentPrice | uint256 |
| expirationTime | uint256 |
| currentOwner | address |
| issuer | address |



## Functions

### buySlot
Called with value to buy the slot



#### Declaration
```solidity
  function buySlot(
    uint256 newPrice
  ) external returns (bool)
```

#### Modifiers:
No modifiers

#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`newPrice` | uint256 | the suggested price by the buyer

### updateSlot
Called to update the slot content



#### Declaration
```solidity
  function updateSlot(
    string newValue
  ) external
```

#### Modifiers:
No modifiers

#### Args:
| Arg | Type | Description |
| --- | --- | --- |
|`newValue` | string | the new content string

### checkExpirationStatus
Internally called to check slot expiration


#### Declaration
```solidity
  function checkExpirationStatus(
  ) internal
```

#### Modifiers:
No modifiers





## Events

### SlotPurchased 📣
Emits when new buyer purchases slot


  

#### Params:
| Param | Type | Indexed | Description |
| --- | --- | :---: | --- |
|`_owner` | address | :white_check_mark: | address of new buyer
|`_price` | uint256 | :white_check_mark: | the new price settled by buyer
|`_expiration` | uint256 | :white_check_mark: | the time uptil which the slot is owned by buyer
### SlotExpirationExtended 📣
Emits when buyer extends duration of slot ownership


  

#### Params:
| Param | Type | Indexed | Description |
| --- | --- | :---: | --- |
|`_owner` | address | :white_check_mark: | address of buyer
|`_newExpiration` | uint256 | :white_check_mark: | the new time uptil which the slot is owned by buyer
### SlotUpdated 📣
Emits when owner updates the slot content


  

#### Params:
| Param | Type | Indexed | Description |
| --- | --- | :---: | --- |
|`_owner` | address | :white_check_mark: | address of buyer
|`_time` | uint256 | :white_check_mark: | the time when content were updated
