import 'package:basics_samples/confirm_field/confirm_field_cubit.dart';
import 'package:basics_samples/confirm_field/confirm_field_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmFieldFormWrapper<T> extends StatefulWidget {
  const ConfirmFieldFormWrapper({
    super.key,
    required this.label,
    this.fieldValidator,
    this.fieldValidatorExtra,
    this.extra,
  }) : assert(fieldValidator != null && fieldValidatorExtra == null ||
            fieldValidator == null && fieldValidatorExtra != null);
  final String label;
  final FieldValidator? fieldValidator;
  final FieldValidatorExtra<T>? fieldValidatorExtra;
  final T? extra;

  @override
  State<ConfirmFieldFormWrapper<T>> createState() => _ConfirmFieldFormWrapperState<T>();
}

class _ConfirmFieldFormWrapperState<T> extends State<ConfirmFieldFormWrapper<T>> {
  // T? _extra;

  // @override
  // void initState() {
  //   super.initState();
  //   _extra = widget.extra;
  // }

  // @override
  // void didUpdateWidget(covariant ConfirmFieldFormWrapper<T> oldWidget) {
  //   if (widget.extra != null && oldWidget.extra != widget.extra) {
  //     _extra = widget.extra;
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmFieldCubit<T>(
        fieldValidator: widget.fieldValidator,
        fieldValidatorExtra: widget.fieldValidatorExtra,
        extra: widget.extra,
      ),
      child: ConfirmFieldForm<T>(
        label: widget.label,
        fieldValidator: widget.fieldValidator,
        fieldValidatorExtra: widget.fieldValidatorExtra,
        extra: widget.extra,
      ),
    );
  }
}

class ConfirmFieldForm<T> extends StatefulWidget {
  const ConfirmFieldForm({
    super.key,
    required this.label,
    this.fieldValidator,
    this.fieldValidatorExtra,
    this.extra,
  }) : assert(fieldValidator != null && fieldValidatorExtra == null ||
            fieldValidator == null && fieldValidatorExtra != null);

  final String label;
  final FieldValidator? fieldValidator;
  final FieldValidatorExtra<T>? fieldValidatorExtra;
  final T? extra;

  @override
  State<ConfirmFieldForm<T>> createState() => _ConfirmFieldFormState<T>();
}

class _ConfirmFieldFormState<T> extends State<ConfirmFieldForm<T>> {
  T? _extra;

  @override
  void initState() {
    super.initState();
    _extra = widget.extra;
  }

  @override
  void didUpdateWidget(covariant ConfirmFieldForm<T> oldWidget) {
    if (widget.extra != null && oldWidget.extra != widget.extra) {
      _extra = widget.extra;
      context.read<ConfirmFieldCubit<T>>().setExtra(_extra!);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmFieldCubit<T>, ConfirmFieldState>(
      builder: (context, state) {
        return Column(
          children: [
            TextFormField(
              onChanged: context.read<ConfirmFieldCubit<T>>().onFieldChanged,
              decoration: InputDecoration(
                label: Text('${widget.label}'),
                errorText: state.fieldErrorMsg,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              onChanged: context.read<ConfirmFieldCubit<T>>().onConfirmFieldChanged,
              decoration: InputDecoration(
                label: Text('Confirm ${widget.label}'),
                errorText: state.confirmFieldErrorMsg,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            TextButton(onPressed: state.isConfirmFormValid ? () {} : null, child: const Text('Valider')),
          ],
        );
      },
    );
    // return BlocProvider(
    //   key: UniqueKey(),
    //   create: (context) => ConfirmFieldCubit<T>(
    //     fieldValidator: widget.fieldValidator,
    //     fieldValidatorExtra: widget.fieldValidatorExtra,
    //     extra: extra,
    //     // extra: widget.extra,
    //   ),
    //   child: BlocBuilder<ConfirmFieldCubit<T>, ConfirmFieldState>(
    //     builder: (context, state) {
    //       return Column(
    //         children: [
    //           TextFormField(
    //             onChanged: context.read<ConfirmFieldCubit<T>>().onFieldChanged,
    //             decoration: InputDecoration(
    //               label: Text('${widget.label}'),
    //               errorText: state.fieldErrorMsg,
    //               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    //             ),
    //           ),
    //           const SizedBox(height: 16),
    //           TextFormField(
    //             onChanged: context.read<ConfirmFieldCubit<T>>().onConfirmFieldChanged,
    //             decoration: InputDecoration(
    //               label: Text('Confirm ${widget.label}'),
    //               errorText: state.confirmFieldErrorMsg,
    //               border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    //             ),
    //           ),
    //           TextButton(onPressed: state.isConfirmFormValid ? () {} : null, child: const Text('Valider')),
    //         ],
    //       );
    //     },
    //   ),
    // );
  }
}
