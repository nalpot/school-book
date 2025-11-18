import 'package:equatable/equatable.dart';

class AboutItemEntity extends Equatable {

  const AboutItemEntity({required this.title, this.url});

  final String title;
  final String? url;

  @override
  List<Object?> get props => [];
}
