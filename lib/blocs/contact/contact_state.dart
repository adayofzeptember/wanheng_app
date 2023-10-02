part of 'contact_bloc.dart';

// ignore: must_be_immutable
class ContactState extends Equatable {
    bool loading;
  ContactState({required this.loading});

    ContactState copyWith({
    bool? loading,
  }) {
    return ContactState(
      loading: loading ?? this.loading,
    );
  }
  
  @override
  List<Object> get props => [loading];
}


