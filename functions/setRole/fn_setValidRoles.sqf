
params ["_target", "_newValidRoles"];

_oldValidRoles = _target getVariable ["validRoles", ["Rifle", "MG"]];

_target setVariable ["validRoles", _newValidRoles, true];

["htz_roles_validRolesUpdated", [_oldValidRoles, _newValidRoles, _target], [_target]] call CBA_fnc_targetEvent;

_newValidRoles;