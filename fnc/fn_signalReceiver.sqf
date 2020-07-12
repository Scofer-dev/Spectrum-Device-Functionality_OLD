//======================================================================================================================================================
// Function: specdev_fnc_spectrumDestination
// Author: Scofer
// Version: 1.0
// Date: 06/07/20
// Description: Sets the spectrumDestination global variable, all spectrum sources will measure their distance from this destination.
//======================================================================================================================================================
private ["_module","_syncArray","_deviceUpdate"];

_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};

receiverMethod = _module getVariable "specdev_spectrumDestination_Method";

switch (true) do {
	case (receiverMethod == 0):
	{
		_syncArray = synchronizedObjects _module;
		signalReceiver = _syncArray select 0;
		publicVariable "spectrumDestination";
	};
	case (receiverMethod == 1):
	{
		_deviceUpdate = abs(_module getVariable "specdev_spectrumDestination_deviceUpdate");
		while {true} do
		{		
			{
				if ("hgun_esd_" in handgunWeapon _x) then
				{
					signalReceiver = _x;
					publicVariable "spectrumDestination";
				};
			} forEach allPlayers;
			sleep _deviceUpdate;
		};
	};
	case (receiverMethod == 2):
	{};
};

deleteVehicle _module;