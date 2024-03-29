_requiredPoints = _this select 0;
_vehicleType = _this select 1;

if (commandpointsblu1 >= _requiredPoints) then {
    commandpointsblu1 = commandpointsblu1 - _requiredPoints;
    ctrlSetText [1000, format["%1",commandpointsblu1]];
    _spawnPos = (getpos hq_blu1) findEmptyPosition [15, 120, _vehicleType];
    if(count _spawnPos != 0) then {
        _spawnPos = [_spawnPos select 0, _spawnPos select 1];
        vehic = _vehicleType createVehicle _spawnPos;

        if(unitIsUAV vehic) then {
            createVehicleCrew vehic;
        };

        if(vehic isKindOf "Tank" || vehic isKindOf "Wheeled_APC_F") then {
            vehic addEventHandler ["IncomingMissile", {
                _target = _this select 0;
                _attacker = _this select 3;
                diag_log format ["DUWS-R: MWS Event Fired for %1", _target];
                if(player in crew (_target)) then {
                    _target say2D ["alarmCar", 100, 1];
                    _azi = (_target) getDir (_attacker);
                    titleText [format["Incoming Missile: Bearing %1", str floor _azi], "PLAIN", 0.4];
                };
            }];
        };
		
		if(typeOf vehic == "I_MRAP_03_F" || typeOf vehic == "I_MRAP_03_hmg_F" || typeOf vehic == "I_MRAP_03_gmg_F") then {
			vehic setObjectTextureGlobal [0,'\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa']; 
			vehic setObjectTextureGlobal [1,'\A3\data_f\vehicles\turret_co.paa'];
		};
		
		if(typeOf vehic == "I_APC_Wheeled_03_cannon_F") then {
			vehic setObjectTextureGlobal [0, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_co.paa"]; 
			vehic setObjectTextureGlobal [1, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext2_co.paa"]; 
			vehic setObjectTextureGlobal [2, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\rcws30_co.paa"]; 
			vehic setObjectTextureGlobal [3, "A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_alpha_co.paa"];
		};
		
        hint "Vehicle ready !";
        } else {
            hint "Not enough room to spawn vehicle!";
        };
} else {
    hint "Not enough command points";
};
