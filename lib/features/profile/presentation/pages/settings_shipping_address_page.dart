import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/profile_entities.dart' show ShippingAddressEntity;
import '../providers/profile_providers.dart';
import '../widgets/settings_subpage_header.dart';
import 'settings_country_page.dart';

/// **Settings** → **Shipping Address** form (mock persistence).
class SettingsShippingAddressPage extends ConsumerStatefulWidget {
  const SettingsShippingAddressPage({super.key});

  @override
  ConsumerState<SettingsShippingAddressPage> createState() =>
      _SettingsShippingAddressPageState();
}

class _SettingsShippingAddressPageState
    extends ConsumerState<SettingsShippingAddressPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _townCtrl = TextEditingController();
  final TextEditingController _postcodeCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();

  String _countryName = '';
  bool _seeded = false;
  bool _saving = false;

  @override
  void dispose() {
    _addressCtrl.dispose();
    _townCtrl.dispose();
    _postcodeCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.hint),
      filled: true,
      fillColor: AppColors.blobLightBlue.withValues(alpha: 0.45),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Future<void> _pickCountry() async {
    final String? picked = await Navigator.of(context).push<String>(
      MaterialPageRoute<String>(
        builder: (_) => SettingsCountryPage(selectedName: _countryName),
      ),
    );
    if (picked != null && mounted) {
      setState(() => _countryName = picked);
    }
  }

  Future<void> _onSave() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    if (_countryName.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose a country')),
      );
      return;
    }
    if (_saving) {
      return;
    }
    setState(() => _saving = true);
    try {
      final ShippingAddressEntity entity = ShippingAddressEntity(
        countryName: _countryName.trim(),
        addressLine: _addressCtrl.text.trim(),
        townCity: _townCtrl.text.trim(),
        postcode: _postcodeCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
      );
      await ref.read(profileRepositoryProvider).saveShippingAddress(entity);
      ref.invalidate(shippingAddressProvider);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<ShippingAddressEntity>>(shippingAddressProvider, (
      AsyncValue<ShippingAddressEntity>? previous,
      AsyncValue<ShippingAddressEntity> next,
    ) {
      next.whenData((ShippingAddressEntity d) {
        if (!_seeded && mounted) {
          _countryName = d.countryName;
          _addressCtrl.text = d.addressLine;
          _townCtrl.text = d.townCity;
          _postcodeCtrl.text = d.postcode;
          _phoneCtrl.text = d.phone;
          setState(() => _seeded = true);
        }
      });
    });

    final AsyncValue<ShippingAddressEntity> asyncAddr =
        ref.watch(shippingAddressProvider);

    return asyncAddr.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (Object e, StackTrace _) => Scaffold(
        body: Center(child: Text('Error: $e')),
      ),
      data: (_) => _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SettingsSubpageHeader(subtitle: 'Shipping Address'),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  children: <Widget>[
                    Text(
                      'Country',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Material(
                      color: AppColors.blobLightBlue.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        key: const Key('settings_shipping_country_row'),
                        borderRadius: BorderRadius.circular(12),
                        onTap: _pickCountry,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  _countryName.trim().isEmpty
                                      ? 'Choose your country'
                                      : _countryName.trim(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: _countryName.trim().isEmpty
                                            ? AppColors.onSurface
                                            : AppColors.primary,
                                      ),
                                ),
                              ),
                              DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: AppColors.onPrimary,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      key: const Key('settings_shipping_address_field'),
                      controller: _addressCtrl,
                      decoration: _fieldDecoration('Address', hint: 'Required'),
                      validator: (String? v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const Key('settings_shipping_town_field'),
                      controller: _townCtrl,
                      decoration:
                          _fieldDecoration('Town / City', hint: 'Required'),
                      validator: (String? v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const Key('settings_shipping_postcode_field'),
                      controller: _postcodeCtrl,
                      keyboardType: TextInputType.text,
                      decoration:
                          _fieldDecoration('Postcode', hint: 'Required'),
                      validator: (String? v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const Key('settings_shipping_phone_field'),
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      decoration:
                          _fieldDecoration('Phone Number', hint: 'Required'),
                      validator: (String? v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 32),
                    FilledButton(
                      key: const Key('settings_shipping_save_button'),
                      onPressed: _saving ? null : _onSave,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _saving
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.onPrimary,
                              ),
                            )
                          : const Text('Save changes'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
