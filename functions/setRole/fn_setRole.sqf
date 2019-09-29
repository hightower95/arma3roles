
params ["_target","_roleToSet"];

_currentRole = [_target] call htz_fnc_getRole;

_validRoles = [_target] call htz_fnc_getValidRoles;

if(_currentRole == "") then {
	if(_roleToSet in _validRoles) then {
		_target setVariable ["selectedRole", _roleToSet, true];
		_roleChangeText = format ["Role changed to %1", _roleToSet];
		diag_log _roleChangeText;
		["ace_common_displayTextStructured", [_roleChangeText, 1.5, _target], [_target]] call CBA_fnc_targetEvent;
	} else {
		diag_log format ["Selected role %1 not a valid role", _roleToSet];
	}

} else {
	if(_roleToSet in _validRoles) then {
		_target setVariable ["selectedRole", _roleToSet, true];
		_roleChangeText = format ["Role changed to %1", _roleToSet];
		diag_log _roleChangeText;
		["ace_common_displayTextStructured", [_roleChangeText, 1.5, _target], [_target]] call CBA_fnc_targetEvent;

	} else {
		diag_log format ["Selected role %1 not a valid role", _roleToSet];
		["ace_common_displayTextStructured", ["Invalid or locked role", 1.5, _target], [_target]] call CBA_fnc_targetEvent;
	}
};

