# This file was created by configpm when Perl was built. Any changes
# made to this file will be lost the next time perl is built.

# for a description of the variables, please have a look at the
# Glossary file, as written in the Porting folder, or use the url:
# https://github.com/Perl/perl5/blob/blead/Porting/Glossary

package Config;
use strict;
use warnings;
our ( %Config, $VERSION );

$VERSION = "5.040000";

# Skip @Config::EXPORT because it only contains %Config, which we special
# case below as it's not a function. @Config::EXPORT won't change in the
# lifetime of Perl 5.
my %Export_Cache = (myconfig => 1, config_sh => 1, config_vars => 1,
                    config_re => 1, compile_date => 1, local_patches => 1,
                    bincompat_options => 1, non_bincompat_options => 1,
                    header_files => 1);

@Config::EXPORT = qw(%Config);
@Config::EXPORT_OK = keys %Export_Cache;

# Need to stub all the functions to make code such as print Config::config_sh
# keep working

sub bincompat_options;
sub compile_date;
sub config_re;
sub config_sh;
sub config_vars;
sub header_files;
sub local_patches;
sub myconfig;
sub non_bincompat_options;

# Define our own import method to avoid pulling in the full Exporter:
sub import {
    shift;
    @_ = @Config::EXPORT unless @_;

    my @funcs = grep $_ ne '%Config', @_;
    my $export_Config = @funcs < @_ ? 1 : 0;

    no strict 'refs';
    my $callpkg = caller(0);
    foreach my $func (@funcs) {
        die qq{"$func" is not exported by the Config module\n}
            unless $Export_Cache{$func};
        *{$callpkg.'::'.$func} = \&{$func};
    }

    *{"$callpkg\::Config"} = \%Config if $export_Config;
    return;
}

die "$0: Perl lib version (5.40.0) doesn't match executable '$^X' version ($])"
    unless $^V;

$^V eq 5.40.0
    or die sprintf "%s: Perl lib version (5.40.0) doesn't match executable '$^X' version (%vd)", $0, $^V;


sub relocate_inc {
  my $libdir = shift;
  return $libdir unless $libdir =~ s!^\.\.\./!!;

  # NX START: TR03S10141

  my $os = $^O;
  my $prefix = $ENV{'NX_SYSTEM'};

  if (!defined $prefix || $prefix eq '') {
    if ($os eq 'linux') {
      $prefix = '/usr/NX';
    } elsif ($os eq 'darwin') {
      $prefix = '/Applications/NoMachine.app/Contents/Frameworks';
    } elsif ($os eq 'MSWin32') {
      $prefix = $ENV{'SystemRoot'} // 'C:\\Windows';
      $prefix .= '\\System32\\NXPerl';
    } else {
      die "Unknown OS ($os) - cannot relocate";
    }
  }

  if (defined $prefix && $prefix ne '') {
    $prefix =~ s@[\\/]+$@@; # remove trailing slash or backslash

    if ($os eq 'MSWin32') {
      $prefix .= "\\bin";
    } else {
      $prefix .= "/bin";
    }

    # NX END TR03S10141

    while ($libdir =~ m!^\.\./!)  {
      # Loop while $libdir starts "../" and $prefix still has a trailing
      # directory
      last unless $prefix =~ s!/([^/]+)$!!;
      # but bail out if the directory we picked off the end of $prefix is .
      # or ..
      if ($1 eq '.' or $1 eq '..') {
        # Undo! This should be rare, hence code it this way rather than a
        # check each time before the s!!! above.
        $prefix = "$prefix/$1";
        last;
      }
      # Remove that leading ../ and loop again
      substr ($libdir, 0, 3, '');
    }
    $libdir = "$prefix/$libdir";
  }
  $libdir;
}

sub FETCH {
    my($self, $key) = @_;

    # check for cached value (which may be undef so we use exists not defined)
    return exists $self->{$key} ? $self->{$key} : $self->fetch_string($key);
}

sub TIEHASH {
    bless $_[1], $_[0];
}

sub DESTROY { }

sub AUTOLOAD {
    require 'Config_heavy.pl';
    goto \&launcher unless $Config::AUTOLOAD =~ /launcher$/;
    die "&Config::AUTOLOAD failed on $Config::AUTOLOAD";
}

# tie returns the object, so the value returned to require will be true.
tie %Config, 'Config', {
    archlibexp => relocate_inc('.../..\\5.40.0\\mingw\\lib'),
    archname => 'MSWin32-x64-multi-thread',
    cc => 'x86_64-w64-mingw32-gcc',
    d_readlink => 'define',
    d_symlink => 'define',
    dlext => 'dll',
    dlsrc => 'dl_win32.xs',
    dont_use_nlink => undef,
    exe_ext => '.exe',
    inc_version_list => '',
    intsize => '4',
    ldlibpthname => '',
    libpth => undef,
    osname => 'MSWin32',
    osvers => '10.0.26100.3775',
    path_sep => ';',
    privlibexp => relocate_inc('.../..\\5.40.0\\mingw\\lib'),
    scriptdir => '.../..\\5.40.0\\mingw\\bin',
    sitearchexp => relocate_inc('.../..\\site\\5.40.0\\mingw\\lib'),
    sitelibexp => relocate_inc('.../..\\site\\5.40.0\\mingw\\lib'),
    so => 'dll',
    useithreads => 'define',
    usevendorprefix => undef,
    version => '5.40.0',
};
