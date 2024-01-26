import 'package:dartz/dartz.dart';
import 'package:error/error.dart';
import 'package:search_donor/src/domain/entities/UserDonor.dart';
import 'package:search_donor/src/domain/repository/search_donor_repository.dart';

class SearchDonorUsecase {
  final SearchDonorRepository searchDonorRepository;

  SearchDonorUsecase({required this.searchDonorRepository});

  Future<Either<Failure, UserDonor>> execute(String email) async {
    return searchDonorRepository.searchDonor(email);
  }
}
