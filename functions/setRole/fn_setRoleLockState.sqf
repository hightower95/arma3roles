params ["_target", "_role"];
_nextLockedStateFlag =  [_this, 2, true, [true]] call BIS_fnc_param;

_successFlag = false;

// Do we need 'available roles'
// RN: assume whoever is adding a role knows what they are doing.
if(_role == "") exitWith {
	_successFlag;
};

_currentRoles = [_target] call htz_fnc_getValidRoles;

if(_nextLockedStateFlag && true) then {
	// Want to lock the role, i.e. remove it from the valid list.
	_id = _currentRoles find _role;
	if(_id > -1) then {
		_filteredRoles = _currentRoles deleteAt _id;
		[_target, _filteredRoles] call htz_fnc_setValidRoles;
	};
	_successFlag = true;

} else {
	// Want to unlock the role, i.e. add it to the valid list.
	if(_role in _currentRoles) then { }
	else {
		_currentRoles pushBack _role;
		[_target, _currentRoles] call htz_fnc_setValidRoles;
	};
	_successFlag = true;
	
};

_successFlag;

