// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.26;

struct squad{
    string TeamName;
    string calldata [] players;
}

struct Playing11{
    string TeamName;
    string[10] players;
    //uint256[10] public myFixedSizeArr;
}

struct PlayerDetails{
    string Name;
    string role;
    uint8 points;
}

interface ITournament{
    event TournamentManagerChanged(address indexed oldTournamentManager, Manager);
    event TournamentNameChanged(string indexed oldTournamentName, string indexed TournamentName);
    event TournamentTeamsCountChanged(uint indexed oldTournamentTeams, uint indexed NewTournamentTeamsCount);

    function AddPlayersForSquad(string TeamName,string PlayerName,uint Points) external;
    function AddPlayersForTeam(string TeamName, string PlayerName) external;
    function CreateDream11Team(string PlayerName) external;
    function changeManager(address NewManager) external;
    function changeTotalTeams(uint _TotalTeams) external;
    function changeTournamentName(string calldata _TournamentName) external;

}
