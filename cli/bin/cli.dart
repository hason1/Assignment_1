import 'package:cli/cli.dart' as cli;
import 'package:cli/classes.dart';

import 'dart:io';

PersonRepository persons = PersonRepository();
VehicleRepository vehicles = VehicleRepository();
ParkingSpaceRepository parking_spaces = ParkingSpaceRepository();
ParkingRepository parkings = ParkingRepository();

void main(List<String> arguments) {

  start_app();

}


void start_app(){
  String? main_option_input = handle_main_options();

  if(main_option_input != null){
    handle_selected_option(option: main_option_input);
  }

}


String? handle_main_options(){
  stdout.writeln('\nVälkommen till Parkeringsappen!\nVad vill du hantera?\n1. Personer\n2. Fordon\n3. Parkeringsplatser\n4. Parkeringar\n5. Avsluta');
  stdout.write('\nVälj ett alternativ (1-5): ');

  List main_options = ['1', '2', '3', '4', '5'];

  String? input = stdin.readLineSync();
  if(input is String && input != null && input.isNotEmpty && main_options.contains(input)){
    if(input == '5'){
      stdout.write('\nProgram avslutad');
      exit(0);
    }
    else {
      return input;
    }
  }
  else {
    stdout.write('\nVälj ett alternativ (1-5): ');
    handle_main_options();
  }


}


void handle_selected_option({required String option}){

  switch (option) {
    case '1':
      person_options();
    case '2':
      vehicle_options();
    case '3':
      parking_space_options();
    case '4':
      parking_options();
    default:
    //  executeUnknown();
  }
}

void person_options({String user_input = ''}){
  List main_options = ['1', '2', '3', '4', '5'];
  String? option;
  if(user_input.isNotEmpty){
    option = user_input;
  }
  else {
    stdout.writeln('\nDu har valt att hantera Personer. Vad vill du göra?\n1. Lägg till ny person\n2. Visa alla personer\n3. Uppdatera person\n4. Ta bort person\n5. Gå tillbaka till huvudmenyn');
    stdout.write('\nVälj ett alternativ (1-5): ');
    option = stdin.readLineSync();
  }

  if(option is String && option != null && option.isNotEmpty && main_options.contains(option)){
    switch (option) {
      case '1': // Skapa ny
        try{
          stdout.write('\nSkriv person namn: ');
          String? person_name = stdin.readLineSync();
          stdout.write('Skriv personnummer: ');
          String? person_number = stdin.readLineSync();

          if(person_name != null && person_name.isNotEmpty && person_number != null && person_number.isNotEmpty){
            persons.add(Person(name: person_name ?? '', person_number: person_number ?? ''));
            print('$person_name tillagd');
            person_options();
          }
          else {
            print('Ett fel har inträffat, vänligen försök igen \n');
            person_options(user_input: option);
          }
        }
        catch(e){
          print('Ett fel har inträffat, vänligen försök igen \n');
          person_options(user_input: option);
        }
      case '2': // Visa alla
        List persons_to_print = persons.getAll();
        if(persons_to_print.isNotEmpty){
          print("\nAlla personer:");
          for (var person in persons_to_print) {
            print("Namn: ${person.name}, Personnummer: ${person.person_number}");
          }
          person_options();
        }
        else {
          print("Inga personer skapade");
          person_options();
        }
      case '3': // Uppdaera
        stdout.write('Skriv personnummeret för personen du vill uppdatera: ');
        String? person_number = stdin.readLineSync();

        if(person_number != null && person_number.isNotEmpty){
          Person? person = persons.getById(person_number);

          if(person != null){
            stdout.write('\nPerson hittad, Skriv person namn: ');
            String? name = stdin.readLineSync();

            if(name != null && name.isNotEmpty){
              person.name = name ?? '';
              print('Person ändrad');
              person_options();
            }
            else{
              person_options(user_input: option);
            }

          }
          else {
            print('Kunde inte hitta personen, vänligen försök igen \n');
            person_options(user_input: option);
          }
        }

      case '4':   // Ta bort

        stdout.write('Skriv personnummeret för personen du vill ta bort: ');
        String? person_number = stdin.readLineSync();

        if(person_number != null && person_number.isNotEmpty){

          Person? person = persons.getById(person_number);

          if(person != null){

            bool result = persons.delete(person.person_number);

            if(result == true){
              print(person.name + ' tog bort');
              person_options();
            }
            else{
              print('Ett fel har inträffat, vänligen försök igen \n');
              person_options(user_input: option);
            }

          }
          else {
            print('Kunde inte hitta personen, vänligen försök igen \n');
            person_options(user_input: option);
          }
        }


      case '5':
        start_app();
      default:
        person_options();
    }
  }
  else {
    person_options();
  }


}


void vehicle_options({String user_input = ''}){

  List main_options = ['1', '2', '3', '4', '5'];
  String? option;
  if(user_input.isNotEmpty){
    option = user_input;
  }
  else {
    stdout.writeln('\nDu har valt att hantera Fordon. Vad vill du göra?\n1. Lägg till nytt fordon\n2. Visa alla fordon\n3. Uppdatera fordon\n4. Ta bort fordon\n5. Gå tillbaka till huvudmenyn');
    stdout.write('\nVälj ett alternativ (1-5): ');
    option = stdin.readLineSync();
  }

  if(option is String && option != null && option.isNotEmpty && main_options.contains(option)){

    // man ska kunna flytta till koden i varje case till egen funktion
    switch (option) {
      case '1': // Lägg till
        try{
          stdout.write('\nSkriv registrering nummer: ');
          String? reg_number = stdin.readLineSync();

          stdout.write('Skriv fordon typ: ');
          String? type = stdin.readLineSync();


          Vehicle? new_vehicle;
          if(reg_number != null && reg_number.isNotEmpty && type != null && type.isNotEmpty){
             new_vehicle =  Vehicle(registration_number: reg_number ?? '', type: type ?? '', );
          }

          stdout.write('Skriv ägarens namn: ');
          String? person_name = stdin.readLineSync();

          stdout.write('Skriv ägarens personnummer: ');
          String? person_number = stdin.readLineSync();


          Person? vehicle_owner;
          if(person_name != null && person_name.isNotEmpty && person_number != null && person_number.isNotEmpty){
             vehicle_owner = Person(name: person_name ?? '', person_number: person_number ?? '');
          }
          else {
            print('Ett fel har inträffat, vänligen försök igen \n');
            vehicle_options(user_input: option);
          }

          if(new_vehicle != null && vehicle_owner != null){
            new_vehicle.person = vehicle_owner;
            vehicles.add(new_vehicle);

            // Kontrollera att personen är inte redan registrerad
            Person? person = persons.getById(vehicle_owner.person_number);
            if(person == null){
              persons.add(vehicle_owner);
            }

            vehicle_options();
          }
          else {
            print('Ett fel har inträffat, vänligen försök igen \n');
            vehicle_options(user_input: option);
          }
        }
        catch(e){
          print('Ett fel har inträffat, vänligen försök igen \n');
          vehicle_options(user_input: option);
        }
      case '2': // Visa alla
        List vehicles_to_print = vehicles.getAll();
        if(vehicles_to_print.isNotEmpty){
          print("\nAlla fordon:");
          for (var vehicle in vehicles_to_print) {
            if(vehicle.person != null){
              print("Regnummer: ${vehicle.registration_number}, Typ: ${vehicle.type}");
              print("Ägeranesnamn: ${vehicle.person.name}, Ägeranes Personnummer: ${vehicle.person.person_number} \n");
            }
          }
          vehicle_options();
        }
        else {
          print("Inga bilar tillagda");
          vehicle_options();
        }
      case '3': // Uppdaera
        stdout.write('\nSkriv regnumret för fordonet du vill uppdatera: ');
        String? reg_number = stdin.readLineSync();

        if(reg_number != null && reg_number.isNotEmpty){
          Vehicle? vehicle = vehicles.getById(reg_number);

          if(vehicle != null){
            stdout.write('\nFordon hittad, Ändra ägeranes namn: ');
            String? name = stdin.readLineSync();

            stdout.write('Skriv ägarens personnummer: ');
            String? person_number = stdin.readLineSync();

            if(name != null && name.isNotEmpty){
              vehicle.person!.name = name ?? '';
              vehicle.person!.person_number = person_number ?? '';
              print('Person ändrad');
              vehicle_options();
            }
            else{
              vehicle_options(user_input: option);
            }

          }
          else {
            print('Kunde inte hitta fordonet, vänligen försök igen');
            vehicle_options(user_input: option);
          }
        }

      case '4':   // Ta bort

        stdout.write('\nSkriv regnumret för fordonet du vill ta bort: ');
        String? reg_number = stdin.readLineSync();

        if(reg_number != null && reg_number.isNotEmpty){

          Vehicle? vehicle = vehicles.getById(reg_number);

          if(vehicle != null){

            bool result = vehicles.delete(vehicle.registration_number);

            if(result == true){
              print(vehicle.registration_number + ' tog bort');
              vehicle_options();
            }
            else{
              print('Ett fel har inträffat, vänligen försök igen');
              vehicle_options(user_input: option);
            }

          }
          else {
            print('Kunde inte hitta fordonet, vänligen försök igen');
            vehicle_options(user_input: option);
          }
        }


      case '5':
        start_app();
      default:
        vehicle_options();
    }
  }
  else {
    vehicle_options();
  }


}

void parking_space_options({String user_input = ''}){

  List main_options = ['1', '2', '3', '4', '5'];
  String? option;
  if(user_input.isNotEmpty){
    option = user_input;
  }
  else {
    stdout.writeln('\nDu har valt att hantera parkeringsplatser. Vad vill du göra?\n1. Lägg till ny parkeringsplats\n2. Visa alla parkeringsplatser\n3. Uppdatera parkeringsplats\n4. Ta bort parkeringsplats\n5. Gå tillbaka till huvudmenyn');
    stdout.write('\nVälj ett alternativ (1-5): ');
    option = stdin.readLineSync();
  }

  if(option is String && option != null && option.isNotEmpty && main_options.contains(option)){

    // man ska kunna flytta till koden i varje case till egen funktion
    switch (option) {
      case '1': // Lägg till
        try{
          stdout.write('\nSkriv parkeringsplats adress: ');
          String? address = stdin.readLineSync();

          stdout.write('Skriv parkeringsplats pris: ');
          String? price = stdin.readLineSync();

          stdout.write('Skriv parkeringsplats nummer: ');
          String? number = stdin.readLineSync();



          ParkingSpace? new_parking_space;
          if(address != null &&  address.isNotEmpty && address.isNotEmpty && price != null && price.isNotEmpty && number != null && number.isNotEmpty){
            new_parking_space =  ParkingSpace(id: generateId(),  address: address ?? '', number: number ?? '', price: price ?? '', );
          }
          else {
            print('Ett fel har inträffat, vänligen försök igen \n');
            parking_space_options(user_input: option);
          }


          if(new_parking_space != null){
            parking_spaces.add(new_parking_space);
            print('Parkeringsplatsen är tillagd \n');

            parking_space_options();
          }
          else {
            print('Ett fel har inträffat, vänligen försök igen \n');
            parking_space_options(user_input: option);
          }
        }
        catch(e){
          print('Ett fel har inträffat, vänligen försök igen \n');
          parking_space_options(user_input: option);
        }
      case '2': // Visa alla
        List parking_spaces_to_print = parking_spaces.getAll();
        if(parking_spaces_to_print.isNotEmpty){
          print("\nAlla parkeringsplatser:");
          for (var park_space in parking_spaces_to_print) {
            if(park_space != null){
              print("Nummer: ${park_space.number}, Adress: ${park_space.address} Pris: ${park_space.price}\n");
            }
          }
          parking_space_options();
        }
        else {
          print("Inga parkeringsplatser tillagda");
          parking_space_options();
        }
      case '3': // Uppdaera
        stdout.write('\nSkriv numret för parkeringsplatsen du vill uppdatera: ');
        String? number = stdin.readLineSync();

        if(number != null && number.isNotEmpty){
          ParkingSpace? parking = parking_spaces.getByNumber(number);

          if(parking != null){
            stdout.write('\nParkeringsplats hittad, Ändra adress: ');
            String? address = stdin.readLineSync();


            if(address != null && address.isNotEmpty){
              parking.address = address ?? '';
              print('Parkeringsplats ändrad');
              parking_space_options();
            }
            else{
              parking_space_options(user_input: option);
            }

          }
          else {
            print('Kunde inte hitta parkeringsplatsen, vänligen försök igen');
            parking_space_options(user_input: option);
          }
        }

      case '4':   // Ta bort

        stdout.write('\nSkriv numret för parkeringsplatsen du vill ta bort: ');
        String? number = stdin.readLineSync();

        if(number != null && number.isNotEmpty){

          ParkingSpace? parking = parking_spaces.getByNumber(number);

          if(parking != null){

            bool result = parking_spaces.delete(parking.number);

            if(result == true){
              print('Parkeringen med numret ' + parking.number + ' togs bort');
              parking_space_options();
            }
            else{
              print('Ett fel har inträffat, vänligen försök igen');
              parking_space_options(user_input: option);
            }

          }
          else {
            print('Kunde inte hitta parkeringsplatsen, vänligen försök igen');
            parking_space_options(user_input: option);
          }
        }


      case '5':
        start_app();
      default:
        parking_space_options();
    }
  }
  else {
    parking_space_options();
  }
}

void parking_options({String user_input = ''}){

  List main_options = ['1', '2', '3', '4', '5'];
  String? option;
  if(user_input.isNotEmpty){
    option = user_input;
  }
  else {
    stdout.writeln('\nDu har valt att hantera Parkeringar. Vad vill du göra?\n1. Lägg till ny parkering\n2. Visa alla parkeringar\n3. Gå tillbaka till huvudmenyn');
    stdout.write('\nVälj ett alternativ (1-5): ');
    option = stdin.readLineSync();
  }

  if(option is String && option != null && option.isNotEmpty && main_options.contains(option)){

    // man ska kunna flytta till koden i varje case till egen funktion
    switch (option) {
      case '1': // Lägg till
        try{

          stdout.write('Skriv registrering nummer: ');
          String? reg_number = stdin.readLineSync();

          stdout.write('Skriv parkeringsplats nummer: ');
          String? park_space_number = stdin.readLineSync();

          Vehicle? vehicle;
          ParkingSpace? parking_space;
          if(reg_number != null && reg_number.isNotEmpty && park_space_number != null && park_space_number.isNotEmpty){
            parking_space =  parking_spaces.getByNumber(park_space_number);
            vehicle =  vehicles.getById(reg_number);
          }
          else {
            print('Fyll i parkeringsplats numret och fordons numret, vänligen försök igen \n');
            parking_options(user_input: option);
          }

          if(parking_space == null || vehicle == null){
            print('Parkeringsplatsen eller fordonet existerar inte, fordon och parkering platsen måste existera för att lägga parkeringen. vänligen försök igen \n');
            parking_options();
          }


          String? start_time = get_valid_time_user_input(text: 'starttid');
          String? end_time = get_valid_time_user_input(text: 'sluttid');


          if(vehicle != null && parking_space != null && start_time != null && start_time.isNotEmpty && end_time != null && end_time.isNotEmpty ){
            Parking parking = Parking(vehicle: vehicle, parking_space: parking_space, start_time: start_time, end_time: end_time);
            parkings.add(parking);

            print('\nParkeringen är skapad \n');

            parking_options();
          }
          else {
            print('\n Ett fel har inträffat, vänligen försök igen \n');
            parking_options(user_input: option);
          }
        }
        catch(e){
          print('\n Ett fel har inträffat, vänligen försök igen \n');
          parking_options(user_input: option);
        }
      case '2': // Visa alla
        List parkings_to_print = parkings.getAll();
        if(parkings_to_print.isNotEmpty){
          print("\nAlla parkeringar:");
          for (var parking in parkings_to_print) {
            if(parking.vehicle != null){
              print("Regnummer: ${parking.vehicle.registration_number}, Typ: ${parking.vehicle.type}");
              print("Ägeranesnamn: ${parking.vehicle.person.name}, Ägeranes Personnummer: ${parking.vehicle.person.person_number}");
            }
            if(parking.parking_space != null){
              print("Adress: ${parking.parking_space.address}, Pris: ${parking.parking_space.price}, Nummer: ${parking.parking_space.number}");
            }

            if(parking.start_time != null && parking.end_time != null){
              print("Starttid: ${parking.start_time}, Sluttid: ${parking.end_time}");
            }
          }
          parking_options();
        }
        else {
          print("Inga parkeringar tillagda");
          parking_options();
        }
      case '3':
        start_app();
      default:
        parking_options();
    }
  }
  else {
    parking_options();
  }


}

String? get_valid_time_user_input({required String text}) {
  final RegExp timePattern = RegExp(r'^(?:[01]\d|2[0-3]):[0-5]\d$'); // Format ska vara HH:mm

  while (true) {
    stdout.write('Skriv ' + text + ' (t.ex. 16:00): ');
    String? input = stdin.readLineSync()?.trim();

    if (input == null || input.isEmpty) {
      print("Fel: Du måste ange en tid.");
      continue;
    }

    if (!timePattern.hasMatch(input)) {
      print("Fel: Ange en giltig tid i formatet HH:mm (t.ex. 16:00).");
      continue;
    }

    return input;
  }
}

String generateId() {
  return DateTime.now().millisecondsSinceEpoch.toString();
}
