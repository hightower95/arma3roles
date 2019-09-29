


_condition = {
(allUnits) findIf {(_x getVariable ["is_quartermaster", false]) && (_x distance _player < 25)}
};

_statement = {
    removeAllWeapons _unit;
};

_action = ["Loadout","Clear","",_statement,_condition] call ace_interact_menu_fnc_createAction;

[(typeOf player), 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;