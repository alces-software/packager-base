################################################################################
## Alces HPC Software Stack - User-specific CPAN configuration
## Copyright (c) 2013 Alces Software Ltd
################################################################################
# This is a user-specific configuration file for CPAN.pm.

require CPAN::Config;

my $user_config = {
    'build_dir' => qq[$ENV{"HOME"}/gridware/share/perl/$ENV{"GRIDWARE_PERL_VERSION"}/cpan/build],
  'cpan_home' => qq[$ENV{"HOME"}/gridware/share/perl/$ENV{"GRIDWARE_PERL_VERSION"}/cpan],
  'histfile' => qq[$ENV{"HOME"}/gridware/share/perl/$ENV{"GRIDWARE_PERL_VERSION"}/cpan/histfile],
  'keep_source_where' => qq[$ENV{"HOME"}/gridware/share/perl/$ENV{"GRIDWARE_PERL_VERSION"}/cpan/sources],
  'make_install_arg' => qq[INSTALLMAN3DIR=$ENV{"HOME"}/gridware/share/perl/$ENV{"GRIDWARE_PERL_VERSION"}/man/man3 INSTALLMAN1DIR=$ENV{"HOME"}/gridware/share/perl/$ENV{"GRIDWARE_PERL_VERSION"}/man/man1],
  'makepl_arg' => qq[PREFIX=$ENV{"HOME"}/gridware/share/perl/$ENV{"GRIDWARE_PERL_VERSION"}],
  'mbuildpl_arg' => qq[--install_base $ENV{"HOME"}/gridware/share/perl/$ENV{"GRIDWARE_PERL_VERSION"}],
  'prefs_dir' => qq[$ENV{"HOME"}/gridware/share/perl/$ENV{"GRIDWARE_PERL_VERSION"}/cpan/prefs]
};

$CPAN::Config = {%$CPAN::Config, %$user_config};
1;
__END__
