# local_people_core

LocalPeople Core Flutter package.


# Project Architecture

## Data Layer
    This layer consists of datasources, repository and data models. It has a dependency only on the domain layer,
    and cannot talk to the presentation layer directly.

    * Data Sources - Deal directly with the raw data from different data sources (REST API, GraphQl,
    Sqlite, …etc).

	* Models - The raw data then will be mapped or converted into models (dart objects) using some
	serialization methods to serialize/deserialize data (Json, Xml, …etc) from and into.

	* Repositories - Contains the real implementations of the abstraction in the domain layer including
	the repositories, so we define the interface (abstracted class) in the domain layer.. then we implement
	that class in the data layer and this is useful because we have the ability to change or add multiple
	implementations without interacting with the Domain layer. Keep in mind that repositories returns entities
	and not models, because the contract written inside the Domain layer, and with that.. we can say that
	the Data layer depends on Domain layer.

## Domain Layer
    This layer consists of usecases, enties, and reposiroties. The inner layer of our architecture is the
    domain layer. Presentation, and Data layers, directly depend on the domain layer. This layer is where
    we encapsulate all our business rules.

    * Usecases - Contains all the use case implementations of our application. These are also called
    “application-specific business rules”. By just checking this package, you can understand what the
    app is doing. A use case class has just one method called something like invoke or run, and it
    performs only what class name says based on the single-responsibility principle. For instance, we
    may have use cases such as GetUser or SetUserName, and we can utilize these for our profile feature
    that we mentioned before.

    * Entities - Contains all the data classes that are used by the entire application. We can encounter
    the usage of these entities in any module.

    * Repositories - Contains the repository contracts. These are the interfaces that our app expects from
    the data module to implement.

## Presentation Layer
    This layer consists of blocs (viewmodels), views, and widgets.

    * Blocs (ViewModels)

    * Views

    * Widgets - Ccontains the reusable widgets that are specific to one feature.

# Folder Structure

## Example Folder Structure
```
├── feature
│   ├── data
│   │   ├── datasources
│   │   │   ├── feature_local_data_source.dart
│   │   │   └── feature_remote_data_source.dart
│   │   ├── models
│   │   │   ├── feature_model.dart
│   │   ├── repositories
│   │   │   ├── feature_repository_impl.dart
│   ├── domain
│   │   ├── entities
│   │   │   └── feature_entity.dart
│   │   ├── repositories
│   │   │   ├── feature_repository.dart
│   │   ├── usecases
│   │   │   ├── feature_usecase1.dart
│   │   │   ├── feature_usecase2.dart
│   ├── ui  |
│   │   ├── blocs
│   │   │   ├── feature_bloc.dart
│   │   │   └── feature_event.dart
│   │   │   └── feature_state.dart
│   │   ├── views
│   │   │   ├── feature_screen.dart
│   │   ├── widgets
│   │   │   ├── feature_widget1.dart
│   │   │   └── feature_widget2.dart
└── feature.dart
```

## Unit Testing

1. Open a terminal

2. Change directory to LocalPeople Core package root directory.

        $ cd <local_people_core_path>

3. Run the flutter test command

        $ flutter test test/core/network/network_info_test.dart or
        
        $ flutter test test/login/data/datasources/user_rest_api_client_test.dart
