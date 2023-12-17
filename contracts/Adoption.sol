pragma solidity ^0.5.0;

contract Adoption {
address[16] public adopters;

struct Pet{
  bytes32 pet_name;
	bytes32 pet_breed;
  uint pet_age;
  bytes32 pet_location;
  uint pet_id;
}

mapping(uint => Pet) public Pets;

// Registering a pet
function register(bytes32 pet_name, bytes32 pet_breed, uint pet_age, bytes32 pet_location, uint pet_id) public returns (uint) {
  Pets[pet_id] = Pet(pet_name, pet_breed, pet_age, pet_location, pet_id);
  return pet_id;
}

//Constructor
constructor() public {
  register("Frieda", "Scottish Terrier", 3, "Lisco, Alabama", 0);
  register("Gina", "Scottish Terrier", 3, "Tooleville, West Virginia", 1);
  register("Collins", "French Bulldog", 2, "Freeburn, Idaho", 2);
  register("Melissa", "Boxer", 2, "Camas, Pennsylvania", 3);
  register("Jeanine", "French Bulldog", 2, "Gerber, South Dakota", 4);
  register("Elvia", "French Bulldog", 3, "Innsbrook, Illinois", 5);
  register("Latisha", "Golden Retriever", 3, "Soudan, Louisiana", 6);
  register("Coleman", "Golden Retriever", 3, "Jacksonwald, Palau", 7);
  register("Nichole", "French Bulldog", 2, "Honolulu, Hawaii", 8);
  register("Fran", "Boxer", 3, "Matheny, Utah", 9);
  register("Leonor", "Boxer", 2, "Tyhee, Indiana", 10);
  register("Dean", "Scottish Terrier", 3, "Windsor, Montana", 11);
  register("Stevenson", "French Bulldog", 3, "Kingstowne, Nevada", 12);
  register("Kristina", "Golden Retriever", 4, "Sultana, Massachusetts", 13);
  register("Ethel", "Golden Retriever", 2, "Broadlands, Oregon", 14);
  register("Terry", "Golden Retriever", 2, "Dawn, Wisconsin", 15);
}

// Adopting a pet
function adopt(uint petId) public returns (uint) {

  adopters[petId] = msg.sender;

  return petId;
}
// Retrieving the adopters
function getAdopters() public view returns (address[16] memory) {
  return adopters;
}

}