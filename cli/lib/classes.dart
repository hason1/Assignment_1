
class Person {
  String name;
  String person_number;

  Person({required this.name, required this.person_number});
}

class Vehicle {
  String registration_number;
  String type;
  Person? person;

  Vehicle({required this.registration_number, required this.type, this.person});
}

class ParkingSpace {
  String id;
  String address;
  String number;
  String price;

  ParkingSpace({required this.id, required this.address, required this.number, required this.price});
}


class Parking {
  Vehicle vehicle;
  ParkingSpace parking_space;
  String? start_time;
  String? end_time;

  Parking({required this.vehicle, required this.parking_space, required this.start_time, required this.end_time});
}

class PersonRepository {
  final List<Person> _persons = [];

  void add(Person person) {
    _persons.add(person);
  }

  List<Person> getAll() {
    return _persons;
  }

  Person? getById(String personNumber) {
    try {
      return _persons.firstWhere((p) => p.person_number == personNumber);
    } catch (e) {
      return null;
    }
  }

  bool update(Person updatedPerson) {
    for (int i = 0; i < _persons.length; i++) {
      if (_persons[i].person_number == updatedPerson.person_number) {
        _persons[i] = updatedPerson;
        return true;
      }
    }
    return false;
  }

  bool delete(String personNumber) {
    try {
      _persons.removeWhere((p) => p.person_number == personNumber);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class VehicleRepository {
  final List<Vehicle> _vehicles = [];

  void add(Vehicle vehicle) {
    _vehicles.add(vehicle);
  }

  List<Vehicle> getAll() {
    return _vehicles;
  }

  Vehicle? getById(String registrationNumber) {
    try {
      return _vehicles.firstWhere((v) => v.registration_number == registrationNumber);
    } catch (e) {
      return null;
    }
  }

  bool update(Vehicle updatedVehicle) {
    for (int i = 0; i < _vehicles.length; i++) {
      if (_vehicles[i].registration_number == updatedVehicle.registration_number) {
        _vehicles[i] = updatedVehicle;
        return true;
      }
    }
    return false;
  }

  bool delete(String registrationNumber) {
    try {
      _vehicles.removeWhere((v) => v.registration_number == registrationNumber);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class ParkingSpaceRepository {
  final List<ParkingSpace> _parkingSpaces = [];

  void add(ParkingSpace parkingSpace) {
    _parkingSpaces.add(parkingSpace);
  }

  List<ParkingSpace> getAll() {
    return _parkingSpaces;
  }

  ParkingSpace? getById(String id) {
    try {
      return _parkingSpaces.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  ParkingSpace? getByNumber(String number) {
    try {
      return _parkingSpaces.firstWhere((p) => p.number == number);
    } catch (e) {
      return null;
    }
  }

  bool update(ParkingSpace updatedParkingSpace) {
    for (int i = 0; i < _parkingSpaces.length; i++) {
      if (_parkingSpaces[i].id == updatedParkingSpace.id) {
        _parkingSpaces[i] = updatedParkingSpace;
        return true;
      }
    }
    return false;
  }

  bool delete(String number) {
    try {
      _parkingSpaces.removeWhere((p) => p.number == number);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class ParkingRepository {
  final List<Parking> _parkings = [];

  void add(Parking parking) {
    _parkings.add(parking);
  }

  List<Parking> getAll() {
    return _parkings;
  }

  Parking? getById(String vehicleRegistration) {
    try {
      return _parkings.firstWhere((p) => p.vehicle.registration_number == vehicleRegistration);
    } catch (e) {
      return null;
    }
  }

  bool update(Parking updatedParking) {
    for (int i = 0; i < _parkings.length; i++) {
      if (_parkings[i].vehicle.registration_number == updatedParking.vehicle.registration_number) {
        _parkings[i] = updatedParking;
        return true;
      }
    }
    return false;
  }

  bool delete(String vehicleRegistration) {
    try {
      _parkings.removeWhere((p) => p.vehicle.registration_number == vehicleRegistration);
      return true;
    } catch (e) {
      return false;
    }
  }
}
