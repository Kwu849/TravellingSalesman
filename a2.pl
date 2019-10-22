% this is a prolog rule file
% This is a declarative solver which generates solutions for a asymmetric travelling salesman problem

% solution(+Path, +RoadNetwork, -SolutionCost, -SolutionPath).
% Path is a list of cities in reverse order of being visited
% RoadNetwork is an adjacency list of the cities in the road network
% SolutionCost is the cost of a tour
% SolutionPath is the tour for which the SolutionCost was calculated
solution(Path, RoadNetwork, SolutionCost, SolutionPath):-
    length(RoadNetwork,1),
    member(Start,Path),
    member((Start,[]),RoadNetwork),
    SolutionCost = 0,
    SolutionPath = [Start,Start].

solution(Path, RoadNetwork, SolutionCost, SolutionPath):-
    Costs = [],
    solution(Path, RoadNetwork, Costs, SolutionCost, SolutionPath).

solution(Path, RoadNetwork, Costs, SolutionCost, SolutionPath):-
    length(RoadNetwork,Length),
    length(Path,Length),
    [End|_] = Path,
    last(Path,Start),
    member((End,Roads), RoadNetwork),
    member((Start,Cost),Roads),
    sumlist([Cost|Costs], SolutionCost),
    reverse([Start|Path], SolutionPath).


solution(Path, RoadNetwork, Costs, SolutionCost, SolutionPath):-
    length(RoadNetwork,CityLength),
    length(Path,PathLength),
    PathLength < CityLength,
    [City|_] = Path,
    member((City,Roads), RoadNetwork),
    member((NewCity,NewCost),Roads),
    member((NewCity,_),RoadNetwork),
    is_set([NewCity|Path]),
    solution([NewCity|Path],RoadNetwork, [NewCost|Costs], SolutionCost, SolutionPath).
