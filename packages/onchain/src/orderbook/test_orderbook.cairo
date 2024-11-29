use starknet::{ContractAddress};
use snforge_std::{
    declare, ContractClassTrait, DeclareResultTrait, start_cheat_caller_address,
    stop_cheat_caller_address, test_address
};
use openzeppelin::presets::interfaces::{ERC20UpgradeableABIDispatcher, ERC20UpgradeableABIDispatcherTrait};
use openzeppelin::utils::serde::SerializedAppend;
use onchain::orderbook::interface::{OrderbookABIDispatcher, OrderbookABIDispatcherTrait};
use onchain::utils::{constants, test_utils};


fn setup_orderbook(erc20_contract_address: ContractAddress) -> (OrderbookABIDispatcher, ContractAddress) {
    // declare Orderbook contract
    let contract_class = declare("Orderbook").unwrap().contract_class();

    // deploy Orderbook contract
    let mut calldata = array![];
    calldata.append_serde(erc20_contract_address);

    let (contract_address, _) = contract_class.deploy(@calldata).unwrap();

    (OrderbookABIDispatcher { contract_address }, contract_address)
}

fn setup() -> (OrderbookABIDispatcher, ContractAddress, ERC20UpgradeableABIDispatcher, ContractAddress) {
    // deploy an ERC20
    let (erc20_strk, erc20_address) = test_utils::setup_erc20(test_address());

    // deploy Orderbook contract
    let (orderbook, contract_address) = setup_orderbook(erc20_strk.contract_address);

    (orderbook, contract_address, erc20_strk, erc20_address)
}

#[test]
fn test_request_inscription_stored_and_retrieved() {
    let (orderbook_dispatcher, contract_address, token_dispatcher, _) = setup();

    let test_taproot_address: ByteArray = "bc1p5d7rjq7g6r4jdyhzks9smlaqtedr4dekq08ge8ztwac72sfr9rusxg3297";
    let test_data: ByteArray = "data";

    token_dispatcher.approve(contract_address, 100);

    orderbook_dispatcher
        .request_inscription(
            test_data, test_taproot_address, 1, 'STRK'.into(), 10
        );

    let expected = ("data", 10); // the inscription data and the submitter fee
    let actual = orderbook_dispatcher.query_inscription(0);
    assert_eq!(expected, actual);

    let expected_contract_balance = 10; // the submitter fee transferred to the contract
    let actual_contract_balance = token_dispatcher.balance_of(contract_address);
    assert_eq!(expected_contract_balance, actual_contract_balance);

    let expected_user_balance = constants::SUPPLY - 10; // the user balance after the request call
    let actual_user_balance = token_dispatcher.balance_of(test_address());
    assert_eq!(expected_user_balance, actual_user_balance);
}

#[test]
#[should_panic]
fn test_request_inscription_fails_wrong_currency() {
    let (orderbook_dispatcher, contract_address, token_dispatcher, _) = setup();

    let test_taproot_address: ByteArray = "test";
    let test_data: ByteArray = "data";

    token_dispatcher.approve(contract_address, 100);

    orderbook_dispatcher
        .request_inscription(
            test_data, test_taproot_address, 1, 'BTC'.into(), 10
        );
}

#[test]
fn test_request_inscription_fails_wrong_taproot_address() {}

#[test]
fn test_request_inscription_fails_insufficient_balance() {}

#[test]
fn test_lock_inscription_works() {}

#[test]
fn test_lock_inscription_fails_status_closed() {}

#[test]
fn test_lock_inscription_fails_prior_lock_not_expired() {}

#[test]
fn test_lock_inscription_fails_inscription_not_found() {}

#[test]
fn test_cancel_inscription_works() {}

#[test]
fn test_cancel_inscription_fails_locked() {}

#[test]
fn test_cancel_inscription_fails_closed() {}

#[test]
fn test_cancel_inscription_fails_canceled() {}

#[test]
fn test() {}
