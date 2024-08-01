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

    function AddPlayersForSquad(string TeamName,string PlayerName,uint Points) external;
    function AddPlayersForTeam(string TeamName, string PlayerName) external;
    function CreateDream11Team(string PlayerName) external;
    
}
