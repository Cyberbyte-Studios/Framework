#include "\life_server\script_macros.hpp"
/*
    File: fn_wantedProfUpdate.sqf
    Author: [midgetgrimm]
    Persistence by: ColinM
    Description:
    Updates name of player if they change profiles
*/
private ["_query","_tickTime","_wantedCheck","_wantedQuery"];
params [
    ["_uid","",[""]],
    ["_name","",[""]]
];

//Bad data check
if (_uid isEqualTo "" ||  {_name isEqualTo ""}) exitWith {};

_wantedCheck = format ["SELECT name FROM wanted WHERE id='%1'",_uid];
_wantedQuery = [_wantedCheck,2] call DB_fnc_asyncCall;
if (count _wantedQuery isEqualTo 0) exitWith {};

if (_name != (_wantedQuery select 0)) then {
    _query = format ["UPDATE wanted SET name='%1' WHERE id='%2'",_name,_uid];
    [_query,2] call DB_fnc_asyncCall;
};
