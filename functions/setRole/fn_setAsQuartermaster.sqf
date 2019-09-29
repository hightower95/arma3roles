// SERVER CHECK
// Make sure that the script is only run on the server
// if (hasInterface && !isServer) exitWith {};
// ====================================================================================

// DECLARE PRIVATE VARIABLES

_unit = [_this, 0] call BIS_fnc_param;

_unit_is_player = isPlayer _unit;
if(_unit_is_player) exitWith {
	hint format ["Players cannot be armourers"]; objNull;
};

// get nearest table
_unit setVariable ["is_quartermaster", true, true];
// _unit setVariable ["assigned_table", objNull, true];
// _unit setVariable ["has_assigned_table", false, true];
// _unit setVariable ["dispensing_enabled", false, true];

// params ["_target", "_player", "_params"]; - goes into 'statement'
_statement = {
	params ["_target", "_player", "_params"];
	// TODO: In this case perhaps player is handing over inventory to _target
	[_player] call htz_fnc_clearLoadout;
	[_player, ""] call htz_fnc_setRole;
};
_action = ["ResetRole","Reset Role","",_statement,{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

[_unit, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

_childActions = {
    params ["_target", "_player", "_params"];
    diag_log format ["_insertChildren [%1, %2, %3]", _target, _player, _params];
	_roles = [_player] call htz_fnc_getValidRoles;
    // Add children to this action
    private _actions = [];
	{
		_role = _x;
		_statement = {
			params ["_target", "_player", "_params"];
			diag_log format ["_statement [%1, %2, %3]", _target, _player, _params];
			_roleSelected = _params;
			[_player, _roleSelected] call htz_fnc_setRole;
		};
		_condition = {
			true;
		};
		_childs = {};
		// The word private is very important here
		private _action = [_role, _role, "", _statement, _condition, {}, _role] call ace_interact_menu_fnc_createAction;
		_actions pushBack [_action, [], _target]; // New action, it's children, and the action's target
	} forEach _roles;
    _actions;
};

_statement = {
	true;
};
_condition = {
	params ["_target", "_player", "_params"];
	(alive _target);
};

_actionSelect = ["Select_Role", "Set Role", "", _statement, _condition, _childActions,[],[0,0,0], 100] call ACE_interact_menu_fnc_createAction;
[_unit, 0, ["ACE_MainActions"], _actionSelect] call ace_interact_menu_fnc_addActionToObject;
