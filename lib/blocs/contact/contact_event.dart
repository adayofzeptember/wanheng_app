// ignore_for_file: must_be_immutable

part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}


class Send_ContactCasual extends ContactEvent {
  var context;
  String getTitle, getContext;

  Send_ContactCasual(
      {required this.getTitle,
      required this.getContext,
      required this.context});
}
