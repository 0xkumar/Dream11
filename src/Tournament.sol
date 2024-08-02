// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.26;

import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "./interfaces/ITournament.sol";


contract Tournament  is ITournament{

    address public immutable Guild;

    address public  Manager;
    uint public  Total_Teams;
    string calldata  TournamentName;


    constructor() {
        _disableInitializers();
    }


    modifier onlyTournamentDeployer(){
        if(msg.sender != Guild) revert CallerOnlyBeTouramentDeployer();
    }


    function initialize(address _Manager, uint _Total_Teams, string calldata _TournamentName) external{
        Manager = _Manager;
        Total_Teams = _Total_Teams;
        TournamentName = _TournamentName;
        Guild = msg.sender;
    }

    function changeManager(address _NewManager) external onlyTournamentDeployer{
        address oldTournamentManager = Manager;
        Manager = _NewManager;

        emit TournamentManagerChanged(oldTournamentManager,Manager);
    }

    function changeTournamentName(string calldata _NewTournamentName) external onlyTournamentDeployer{
        string memory oldTournamentName = TournamentName;
        TournamentName = _NewTournamentName;
        
        emit TournamentNameChanged(oldTournamentName,TournamentName);

    }

}