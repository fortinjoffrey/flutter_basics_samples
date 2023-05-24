enum URLTypes {
  pdf,
  pdf_large,
  website,
  website_ssl_issue,
}

String getURLForType(URLTypes type) {
  switch (type) {
    case URLTypes.pdf:
      return 'https://www.africau.edu/images/default/sample.pdf';
    case URLTypes.pdf_large:
      return 'https://eu.ftp.opendatasoft.com/stif/PlansRegion/Plans/PLAN_POCHE_RESEAU.pdf';
    case URLTypes.website:
      return 'https://flutter.dev';
    case URLTypes.website_ssl_issue:
      return 'https://ciam-essai.mgen.fr/auth/realms/ciam/protocol/openid-connect/token';
  }
}
