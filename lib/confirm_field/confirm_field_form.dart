import 'package:basics_samples/confirm_field/confirm_field_cubit.dart';
import 'package:basics_samples/confirm_field/confirm_field_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmFieldForm extends StatelessWidget {
  const ConfirmFieldForm({
    super.key,
    required this.label,
    required this.fieldValidator,
  });

  final String label;
  final FieldValidator fieldValidator;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmFieldCubit(fieldValidator: fieldValidator),
      child: BlocBuilder<ConfirmFieldCubit, ConfirmFieldState>(
        builder: (context, state) {
          return Column(
            children: [
              TextFormField(
                onChanged: context.read<ConfirmFieldCubit>().onFieldChanged,
                decoration: InputDecoration(
                  label: Text('$label'),
                  errorText: state.fieldErrorMsg,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                onChanged: context.read<ConfirmFieldCubit>().onConfirmFieldChanged,
                decoration: InputDecoration(
                  label: Text('Confirm $label'),
                  errorText: state.confirmFieldErrorMsg,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              TextButton(onPressed: state.isConfirmFormValid ? () {} : null, child: const Text('Valider')),
            ],
          );
        },
      ),
    );
  }
}
