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

_action = ["Loadout","Clear Equipment","",{removeAllWeapons _player; removeBackpack _player; removeVest _player;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

_actionSelect = ["Select_Role", "Set Role", ""] call ACE_interact_menu_fnc_createAction;

[_unit, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
[_unit, 0, ["ACE_MainActions"], _actionSelect] call ace_interact_menu_fnc_addActionToObject;

_roles = ["Rifle", "Medic", "Specialist", "AT", "MG", "Leader"];
_modes = ["Assault", "Patrol", "Overnight"];

{
	_role = _x;
	_statement = {
		params ["_target", "_player", "_params"];
		diag_log format ["_statement [%1, %2, %3]", _target, _player, _params];

		// Run on hover:
		["ace_common_displayTextStructured", ["someone is thinking of giving you items", 1.5, _target], [_target]] call CBA_fnc_targetEvent;
	};
	_condition = {
		true
	};
	_insertChildren = {
		params ["_target", "_player", "_params"];
		diag_log format ["_insertChildren [%1, %2, %3]", _target, _player, _params];

		_selected_role = _params select 0;
		_modes = _params select 1;

		// Add children to this action
		private _actions = [];
		{
			private _childStatement = {
				_params = _this select 2;
				_role_selected = _params select 0;
				_mode_selected = _params select 1;
				diag_log format ["%1:%2",_role_selected, _mode_selected];};
			private _action = [format ["item:%1",_x], _x, "", _childStatement, {true}, {}, [_selected_role, _x]] call ace_interact_menu_fnc_createAction;
			 _actions pushBack [_action, [], _target]; // New action, it's children, and the action's target
		} forEach _modes;

		_actions
	};
	_action = [_role, _role,"",_statement, _condition, _insertChildren, [_role, _modes]] call ace_interact_menu_fnc_createAction;

	[_unit, 0, ["ACE_MainActions", "Select_Role"], _action] call ace_interact_menu_fnc_addActionToObject;

} forEach _roles;



// for param 10 in create action
// params ["_target", "", "_args", "_actionData"];

// // Convert damage to number (round up to show even slight damage)
// private _color = ceil linearConversion [0, 1, _target getHitPointDamage (_args select 0), 0, 8, true];
// TRACE_2("Modifying icon color",_target,_color);
// (_actionData select 2) set [1, DAMAGE_COLOR_SCALE select _color];