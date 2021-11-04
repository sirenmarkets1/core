// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.0;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import {IAddressesProvider} from "./IAddressesProvider.sol";

/**
 * @title AddressesProvider contract
 * @dev Main registry of addresses part of or connected to the protocol, including permissioned roles
 * @author Dakra-Mystic
 **/
contract AddressesProvider is Ownable, IAddressesProvider {
    mapping(bytes32 => address) private _addresses;

    bytes32 private constant PRICE_ORACLE = "PRICEE_ORACLE";
    bytes32 private constant AMM_DATA_PROVIDER = "AMM_DATA_PROVIDER";
    bytes32 private constant SERIES_CONTROLLER = "SERIES_CONTROLLER";
    bytes32 private constant POOL_ADMIN = "POOL_ADMIN";
    bytes32 private constant EMERGENCY_ADMIN = "EMERGENCY_ADMIN";
    bytes32 private constant VOLATILITY_ORACLE = "VOLATILITY_ORACLE";
    bytes32 private constant BLACKSCHOLES = "BLACKSCHOLES";

    /**
     * @dev Sets an address for an id replacing the address saved in the addresses map
     * IMPORTANT Use this function carefully, as it will do a hard replacement
     * @param id The id
     * @param newAddress The address to set
     */
    function setAddress(bytes32 id, address newAddress)
        external
        override
        onlyOwner
    {
        _addresses[id] = newAddress;
        emit AddressSet(id, newAddress, false);
    }

    /**
     * @dev Returns an address by id
     * @return The address
     */
    function getAddress(bytes32 id) public view override returns (address) {
        return _addresses[id];
    }

    /**
     * @dev The functions below are getters/setters of addresses that are outside the context
     * of the protocol hence the upgradable proxy pattern is not used
     **/

    function getPoolAdmin() external view override returns (address) {
        return getAddress(POOL_ADMIN);
    }

    function setPoolAdmin(address admin) external override onlyOwner {
        _addresses[POOL_ADMIN] = admin;
        emit ConfigurationAdminUpdated(admin);
    }

    function getEmergencyAdmin() external view override returns (address) {
        return getAddress(EMERGENCY_ADMIN);
    }

    function setEmergencyAdmin(address emergencyAdmin)
        external
        override
        onlyOwner
    {
        _addresses[EMERGENCY_ADMIN] = emergencyAdmin;
        emit EmergencyAdminUpdated(emergencyAdmin);
    }

    function getPriceOracle() external view override returns (address) {
        return getAddress(PRICE_ORACLE);
    }

    function setPriceOracle(address priceOracle) external override onlyOwner {
        _addresses[PRICE_ORACLE] = priceOracle;
        emit PriceOracleUpdated(priceOracle);
    }

    function getAmmDataProvider() external view override returns (address) {
        return getAddress(AMM_DATA_PROVIDER);
    }

    function setAmmDataProvider(address ammDataProvider)
        external
        override
        onlyOwner
    {
        _addresses[AMM_DATA_PROVIDER] = ammDataProvider;
        emit AmmDataProviderUpdated(ammDataProvider);
    }

    function getSeriesController() external view override returns (address) {
        return getAddress(SERIES_CONTROLLER);
    }

    function setSeriesController(address seriesController)
        external
        override
        onlyOwner
    {
        _addresses[SERIES_CONTROLLER] = seriesController;
        emit SeriesControllerUpdated(seriesController);
    }

    function getVolatilityOracle() external view override returns (address) {
        return getAddress(VOLATILITY_ORACLE);
    }

    function setVolatilityOracle(address volatilityOracle)
        external
        override
        onlyOwner
    {
        _addresses[VOLATILITY_ORACLE] = volatilityOracle;
        emit VolatilityOracleUpdated(volatilityOracle);
    }

    function getBlackScholes() external view override returns (address) {
        return getAddress(BLACKSCHOLES);
    }

    function setBlackScholes(address blackScholes) external override onlyOwner {
        _addresses[BLACKSCHOLES] = blackScholes;
        emit BlackScholesUpdated(blackScholes);
    }
}
