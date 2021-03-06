
pragma solidity >=0.4.22 <0.8.0;

contract base_contract{
  address owner;
  constructor() public {
    owner=msg.sender;
  }
  mapping(address=>uint256) public voterAadhar;
  mapping(uint256=>address) public contestants;
  mapping(address=>uint256) public votes;
  mapping(uint256=>string) public contestantImage;
  uint256[] public contestantIds;
  event contestantAdded(address contestant,string contestantImage);
  event voted(address contestant, address voter, uint256 currentVoteCount);

  bool paused=false;

  modifier godMode(){
    require(msg.sender==owner,"Only owner can perform this action");
    _;
  }

  modifier isContractActive(){
    require(paused==false,"Contract is already suspeded");
    _;
  }

  function disableContract() public godMode isContractActive{
    paused=true;
  }

  function contractStatus() public view returns (bool){
    return paused;
  }

  function getIds() public view returns(uint256[] memory){
    return contestantIds;
  }

  function addContestants(uint contestantId, address contestantAddress, string memory image) public godMode isContractActive{
    contestants[contestantId]=contestantAddress;
    contestantImage[contestantId]=image;
    contestantIds.push(contestantId);
    emit contestantAdded(contestants[contestantId],image);
  }

  function voteFor(uint contestantId,uint voterAadharNo) public isContractActive{
    votes[contestants[contestantId]]+=1;
    voterAadhar[msg.sender]=voterAadharNo;
    emit voted(contestants[contestantId],msg.sender,votes[contestants[contestantId]]);
  }




}
