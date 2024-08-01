// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.26;

interface IFactory{

    event TournamentDeployed(address indexed tournamentAddress);
    event TournamentManagerChanged(address indexed oldTournamentManager, address indexed NewTournamentManager);
    event TournamentNameChanged(string calldata oldtournamentName, string calldata NewTournamentName);
    
    function deployTournament(address TournamentManager, string calldata _TournamnetName)external;
    function changeManager(address NewTournamentManager) external;
    function changetournamenName(string calldata NewTournamentName) external;
    function getTournamentName() external view returns (string);
    function getTournamentManager() external view returns (address);

}