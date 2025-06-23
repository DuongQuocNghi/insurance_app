class RandomUserOutput {
  final List<UserInfo>? results;
  final Info? info;

  RandomUserOutput({
    this.results,
    this.info,
  });

  factory RandomUserOutput.fromJson(Map<String, dynamic> json) {
    return RandomUserOutput(
        results: json['results'] == null ? null 
            : (json['results'] as List).map((item) => UserInfo.fromJson(item)).toList(),
        info: json['info'] == null ? null : Info.fromJson(json['info']),
    );
  }
}

class Info {
  final String? seed;
  final int? results;
  final int? page;
  final String? version;

  Info({
    this.seed,
    this.results,
    this.page,
    this.version,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      seed: json['seed'],
      results: json['results'],
      page: json['page'],
      version: json['version'],
    );
  }
}

class UserInfo {
  final String? gender;
  final Name? name;
  final Location? location;
  final String? email;
  final Login? login;
  final Dob? dob;
  final Dob? registered;
  final String? phone;
  final String? cell;
  final Id? id;
  final Picture? picture;
  final String? nat;

  UserInfo({
    this.gender,
    this.name,
    this.location,
    this.email,
    this.login,
    this.dob,
    this.registered,
    this.phone,
    this.cell,
    this.id,
    this.picture,
    this.nat,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      gender: json['gender'],
      name: json['name'] == null ? null : Name.fromJson(json['name']),
      location: json['location'] == null ? null : Location.fromJson(json['location']),
      email: json['email'],
      login: json['login'] == null ? null : Login.fromJson(json['login']),
      dob: json['dob'] == null ? null : Dob.fromJson(json['dob']),
      registered: json['registered'] == null ? null : Dob.fromJson(json['registered']),
      phone: json['phone'],
      cell: json['cell'],
      id: json['id'] == null ? null : Id.fromJson(json['id']),
      picture: json['picture'] == null ? null : Picture.fromJson(json['picture']),
      nat: json['nat'],
    );
  }
}

class Dob {
  final DateTime? date;
  final int? age;

  Dob({
    this.date,
    this.age,
  });

  factory Dob.fromJson(Map<String, dynamic> json) {
    return Dob(
      date: json['date'] == null ? null : DateTime.parse(json['date']),
      age: json['age'],
    );
  }
}

class Id {
  final String? name;
  final String? value;

  Id({
    this.name,
    this.value,
  });

  factory Id.fromJson(Map<String, dynamic> json) {
    return Id(
      name: json['name'],
      value: json['value'],
    );
  }
}

class Location {
  final Street? street;
  final String? city;
  final String? state;
  final String? country;
  final String? postcode;
  final Coordinates? coordinates;
  final Timezone? timezone;

  Location({
    this.street,
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.coordinates,
    this.timezone,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      street: json['street'] == null ? null : Street.fromJson(json['street']),
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postcode: json['postcode']?.toString(),
      coordinates: json['coordinates'] == null ? null : Coordinates.fromJson(json['coordinates']),
      timezone: json['timezone'] == null ? null : Timezone.fromJson(json['timezone']),
    );
  }
}

class Coordinates {
  final String? latitude;
  final String? longitude;

  Coordinates({
    this.latitude,
    this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class Street {
  final int? number;
  final String? name;

  Street({
    this.number,
    this.name,
  });

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(
      number: json['number'],
      name: json['name'],
    );
  }
}

class Timezone {
  final String? offset;
  final String? description;

  Timezone({
    this.offset,
    this.description,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) {
    return Timezone(
      offset: json['offset'],
      description: json['description'],
    );
  }
}

class Login {
  final String? uuid;
  final String? username;
  final String? password;
  final String? salt;
  final String? md5;
  final String? sha1;
  final String? sha256;

  Login({
    this.uuid,
    this.username,
    this.password,
    this.salt,
    this.md5,
    this.sha1,
    this.sha256,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      uuid: json['uuid'],
      username: json['username'],
      password: json['password'],
      salt: json['salt'],
      md5: json['md5'],
      sha1: json['sha1'],
      sha256: json['sha256'],
    );
  }
}

class Name {
  final String? title;
  final String? first;
  final String? last;

  Name({
    this.title,
    this.first,
    this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      title: json['title'],
      first: json['first'],
      last: json['last'],
    );
  }
}

class Picture {
  final String? large;
  final String? medium;
  final String? thumbnail;

  Picture({
    this.large,
    this.medium,
    this.thumbnail,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      large: json['large'],
      medium: json['medium'],
      thumbnail: json['thumbnail'],
    );
  }
}
