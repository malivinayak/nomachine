package libnxh;

$VERSION = '9';

require Exporter;
require DynaLoader;

@ISA= qw( Exporter DynaLoader );
    # Items to export into callers namespace by default. Note: do not export
    # names by default without a very good reason. Use EXPORT_OK instead.
    # Do not simply export all your public functions/methods/constants.
@EXPORT = qw();

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.
}
bootstrap libnxh;
# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;

