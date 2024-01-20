/// Why make another module initializer just for the init configuration?
///
/// We aren’t allowed to add the Data module directly into the App module,
/// but the App module contains the main() function. This prevents us from
/// initializing the configurations of the Data module in the main() function.
/// So, we need to create a new module Initializer to be added to the
/// Data, Domain, and Core modules in this module, and then add this module to
/// the App module. We've indirectly added the Data module to the App module.
library initializer;

export 'app_initializer.dart';
