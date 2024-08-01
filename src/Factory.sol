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
contract Factory is IFactory, Ownable2Step{

    address private immutable ORG_IMPL;

    mapping(address => TournamentDetails) private Tournaments;
    mapping (string => address) private TournamentNameToAddress;
    //mapping(address => mapping(string => ))

    constructor(address _orgImpl) Ownable(msg.sender){
        ORG_IMPL = _orgImpl;
    }

    function deployTournament(address Manager, uint Total_Teams, string calldata TournamentName) external onlyOwner{
        ITournament Tournament = ITournament(Clones.clone(ORG_IMPL));
        Tournament.initialize(Manager,Total_Teams);

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
