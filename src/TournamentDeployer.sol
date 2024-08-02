// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.26;

import "@openzeppelin/contracts/access/Ownable2Step.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "./Tournament.sol";
import "./interfaces/IFactory.sol";
import "./Errors.sol";
/**
Todo
1. If the Ipl is played in the next Year the names will be same
Answer: We can keep the Tournaments Name by including the year.
 */
contract TournamentDeployer is ITournamentDeployer, Ownable2Step{

    address private immutable ORG_IMPL;

    mapping(address => TournamentDetails) private Tournaments;
    mapping (string => address) private TournamentNameToAddress;
    //mapping(address => mapping(string => ))

    constructor(address _orgImpl) Ownable(msg.sender){
        ORG_IMPL = _orgImpl;
    }

    function deployTournament(address Manager, uint Total_Teams, string calldata TournamentName) external onlyOwner{
        ITournament Tournament = ITournament(Clones.clone(ORG_IMPL));
        Tournament.initialize(Manager,Total_Teams,TournamentName);

        TournamentNameToAddress[tournamentName] = address(Tournament);
        TournamentDetails memory Tournament_Details =  TournamentDetails({

            TournamentAddress : address(tournament),
            TournamentManager : Manager,
            TournamentName : TournamentName,
            Total_Teams : Total_Teams,
            });

        Tournaments[address(Tournament)] = Tournament_Details;

        emit TournamentDeployed(address indexed Manager, uint indexed Total_Teams, string indexed TournamentName);
    }

    function changeManager(address _newTournamentManager, string calldata _TournamentName ) external onlyOwner{
        address TournamentContractAddress = TournamentNameToAddress[_TournamentName];
        address oldTournamentManager = Tournaments[TournamentContractAddress].Manager
        Tournaments[TournamentContractAddress].Manager = _newManager;
        ITournament(TournamentContractAddress).changeManager(_newManager);
        emit TournamentManagerChanged(address indexed oldTournamentManager, address indexed _newTournamentManager);
    }

    function changeTournamentName(string calldata _newTournamentName, string calldata _TournamentName, address TournamentAddress) external onlyOwner{
        if(bytes(_newTournamentName).lenght() == 0) revert EmptyTournamentName();
        if(bytes(_TournamentName).lenght != 0 && TournamentNameToAddress[_TournamentName] == address(0)) revert InavlidTournamentName();
        if(TournamnetAddress != address(0) && Tournaments[TournamentAddress].TournamentAddress == address(0)) revert InValidTournamentAddress();
        if(TournamentAddress == address(0)){
            TournamentAddress = TournamentNameToAddress[_TournamentName];
            Tournaments[TournamentAddress].tournamentName = _newTournamentName;
            ITournament(TournamentAddress).changeTournamentName(_newTournamentName);
        }
        else{
            Tournaments[TournamentAddress].tournamentName = _newTournamentName;
            ITournament(TournamentAddress).changeTournamentName(_newTournamentName);
        }

        emit TournamentNamechanged(_newTournamentName,_TournamentName);
    }

    function changeTotalParticipatingTeams(address TournamentAddress, string calldata TournamentName, uint TeamsCount) external onlyOwner{
        
        if((TournamentAddress == address(0) && bytes(TournametName).length == 0) || TeamsCount == 0) revert InvalidTeamCount();
        if(TournamentAddress != address(0) && Tournaments[TournamentAddress].TournamentAddress == address(0)) revert InValidTournamentAddress();
        if(bytes(TournamentName).length != 0 && TournamentNameToAddress[TournamentName] == address(0)) revert InvalidTeamName();
        if(TournamentAddress == address(0)){
            address TournamentAddress = TournamentNameToAddress[TournamentName];
            Tournaments[TournamentAddress].Total_Teams = TeamsCount;
            
        }
    }

    function getTournamentAddressByName(string calldata TournamentName) external view returns (tournament_address){
        address tournament_address  = TournamentNameToAddress[TournamentName];
    }

    function getTournamentManager(address TournamentAddress) external returns (TournamentManager){
        address TournamentManager = Tournaments[TournamentAddress].TournamentManager;
    }

    function getTotalTeamsInTournament(string calldata TournamentName) external returns(TeamsCount){
        address TournamentAddress = TournamentNameToAddress[TournamentName];
        uint TeamsCount = Tournaments[TournamentAddress].Total_Teams;
    }

}
