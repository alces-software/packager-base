# -*- mode: perl; coding: utf-8-unix -*-
#
# Author:      Peter John Acklam
# Time-stamp:  2009-03-30 16:22:42 +02:00
# E-mail:      pjacklam@online.no
# URL:         http://home.online.no/~pjacklam

=pod

=head1 NAME

Statistics::Distrib::Normal - the normal distribution

=head1 SYNOPSIS

    use Statistics::Distrib::Normal;

    $dist = Statistics::Distrib::Normal->new(mu    => 3,
                                             sigma => 5);
    @x = $dist->rand(10);        # generate random numbers

    $dist->set(mu => 2);         # change parameter value
    @p = $dist->ltp(2, 3);       # lower tail probabilities

=head1 DESCRIPTION

This module contains miscellaneous functions related to the normal
distribution.

=cut

package Statistics::Distrib::Normal;
require 5.000;

use strict;
use vars qw($VERSION);
use Carp;

$VERSION = '0.01';

#use constant PI    => 4 * atan2 1, 1;
use constant PI    => atan2 0, -1;
use constant TWOPI => 2 * PI;

#use constant SQRT2PI =>

# the smallest positive floating-point number such that 1+EPS > 1
use constant EPS   => 2.220446049250313080847263336181640625e-016;

=pod

=head1 CONSTRUCTOR

=over 4

=item new ( [ OPTIONS ] )

C<OPTIONS> is a list of options given in the form of key-value pairs, just like
a hash table.  Valid options are

=over 8

=item B<mu>

Sets the mu parameter (the mean) of the distribution to the specified value.

=item B<sigma>

Sets the sigma parameter (the standard deviation) of the distribution to the
specified value.

=back

=back

=cut

sub new {
    my $self  = shift;
    my $class = ref($self) || $self;
    my %args  = @_;

    my %hash = (mu    => 0,
                sigma => 1,
               );

    my $me = bless \%hash, $class;

    while (my ($param, $value) = each %args) {
        unless (exists $hash{$param}) {
            carp "invalid parameter: $param\n";
            next;
        }
        $me->{$param} = $value;
    }

    return $me;
}

=pod

=head1 METHODS

=over 4

=item set ( ... )

This method can be used to change the parameters of the distribution.  This
method accepts any parameter allowed by the C<new()> method.

=cut

sub set {
    my $self = shift;

    my %args = @_;
    my $new_self = (ref $self)->new(%$self, %args);

    %$self = %$new_self;
}

=pod

=item pdf ( X1 [, X2 ... ] )

Evaluate the probability density function at C<X1>, C<X2>, ...

=cut

sub pdf {
    my $me = shift;
    croak 'Not enough arguments' if @_ < 1;
    my $mu    = $me->{mu};
    my $sigma = $me->{sigma};
    my $const = log(TWOPI * $sigma * $sigma);
    my @f;
    foreach my $x (@_) {
        my $z = ($x - $mu) / $sigma;
        push @f, exp(-0.5 * ($const + $z*$z));
    }
    return @f if wantarray;
    return $f[0];
}

=pod

=item ltp ( X1 [, X2 ... ] )

Evaluate the lower tail probability function at C<X1>, C<X2>, ...

=cut

sub ltp {
    my $me = shift;
    croak 'Not enough arguments' if @_ < 1;
    my $mu    = $me->{mu};
    my $sigma = $me->{sigma};

    require Math::SpecFun::Erf;
    import Math::SpecFun::Erf qw(erfc);

    my @p;
    foreach my $x (@_) {
        my $z = ($x - $mu) / $sigma;
        push @p, erfc(-$z / sqrt(2))/2;
    }
    return @p if wantarray;
    return $p[0];
}

=pod

=item utp ( X1 [, X2 ... ] )

Evaluate the upper tail probability function at C<X1>, C<X2>, ...

=cut

sub utp {
    my $me = shift;
    croak 'Not enough arguments' if @_ < 1;
    my $mu    = $me->{mu};
    my $sigma = $me->{sigma};

    require Math::SpecFun::Erf;
    import Math::SpecFun::Erf qw(erfc);

    my @p;
    foreach my $x (@_) {
        my $z = ($x - $mu) / $sigma;
        push @p, erfc($z / sqrt(2))/2;
    }
    return @p if wantarray;
    return $p[0];
}

=pod

=item ltq ( P1 [, P2 ... ] )

Returns the lower tail quantile for the probabilities C<P1>, C<P2>, ...

=cut

sub ltq {
    croak 'Method not implemented yet';
}

=pod

=item utq ( P1 [, P2  ... ] )

Returns the upper tail quantile for the probabilities C<P1>, C<P2>, ...

=cut

sub utq {
    croak 'Method not implemented yet';
}

=pod

=item intprob( XLOW, XHIGH )

Interval probability.  Returns the probability of an outcome in the
interval from XLOW to XHIGH.

=cut

sub intprob {
    my $me = shift;
    croak 'Not enough arguments' if @_ < 2;
    croak 'Too many arguments'   if @_ > 2;
    my ($xlow, $xhigh) = @_;
    return 0 unless $xlow < $xhigh;
    my $mu    = $me->{mu};
    my $sigma = $me->{sigma};

    if ($mu < $xlow) {
        return $me->utp($xlow)  - $me->utp($xhigh);
    } else {
        return $me->ltp($xhigh) - $me->ltp($xlow);
    }
}

=pod

=item rand( [ NUM ] )

Generate random variables.  If C<NUM> is omitted, a single variable is
returned.

=cut

sub rand {
    my $me = shift;
    my $num;
    if (@_) {
        $num = shift;
        croak 'Too many arguments' if @_ > 1;
        croak 'Argument must be positive integer'
          unless ($num == int $num) && ($num > 0);
    } else {
        $num = 1;
    }

    # Generate the random variables by the Box-Muller method.
    my @z;
    my $mu    = $me->{mu};
    my $sigma = $me->{sigma};
    my $const = -2 * $sigma * $sigma;
    my $i;
    for ($i = 0 ; $i < $num ; $i += 2) {
        my $r = sqrt $const * log rand;
        my $t = TWOPI * rand;
        push @z, $mu + $r * sin $t, $mu + $r * cos $t;
    }
    pop @z if $i > $num;
    return @z if wantarray;
    return $z[0];
}

=pod

=item expectation ()

Return the expectation of the distribution.

=cut

sub expectation {
    my $me = shift;
    croak 'Too many arguments' if @_;
    return $me->{mu};
}

=pod

=item variance ()

Return the variance of the distribution.

=cut

sub variance {
    my $me = shift;
    croak 'Too many arguments' if @_;
    return $me->{sigma}**2;
}

=pod

=item skewness ()

Return the skewness of the distribution.

=cut

sub skewness {
    my $me = shift;
    croak 'Too many arguments' if @_;
    return 0;
}

=pod

=item kurtosis ()

Return the kurtosis (normalized) of the distribution.

=cut

sub kurtosis {
    my $me = shift;
    croak 'Too many arguments' if @_;
    return 0;
}

=pod

=item dmo ()

Direct moments for the distribution.

Not implemented yet.

=cut

sub dmo {
    croak 'Method not implemented yet';
}

=pod

=item cmo ()

Central moments for the distribution.

=cut

sub cmo {
    croak 'Method not implemented yet';
}

=pod

=item mode ()

Returns the mode of the distribution.

=cut

sub mode {
    my $me = shift;
    croak 'Too many input arguments' if @_;
    return $me->{mu};
}

=pod

=back

=head1 BUGS

None known.

=head1 LIMITATIONS

Degenerate cases are not allowed for most methods; e.g., a distribution with
zero variance.

=head1 HISTORY

=over 4

=item Version 0.02

Code formatting changes.

=item Version 0.01

First release.

=back

=head1 AUTHOR

Peter John Acklam E<lt>pjacklam@online.noE<gt>.

=head1 COPYRIGHT/LICENSE

Copyright 1999-2000 Peter John Acklam.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

1;                              # Modules must return true.

__END__

=pod

The relation between the cumulative normal distribution function and the error
function.

The cumulative standard normal distribution function is defined as

    Phi(x)  = integral from -infinity to x of
                 1 / sqrt(2*pi) * exp(-1/2 * t^2)  dt

The error function and the complementary error functions are defined as

    erf(x)  = integral from 0 to x of  2 / sqrt(pi) exp(-t^2)  dt
    erfc(x) = 1 - erf(x)

By substituting

    u = x / sqrt(2)

one can show that

    Phi(x) = ( 1 + erf(u) ) / 2
           = ( 1 + erf(x / sqrt(2)) ) / 2

Furthermore, one can also show that

    Phi(x) = 1 - Phi(-x)

    erf(x) = -erf(-x)

    erfc(x) = 2 - erfc(-x)

By combining all of this, we get

    Phi(x) = ( 1 +      erf(u)  ) / 2
           = ( 1 + 1 - erfc(u)  ) / 2
           = ( 2     - erfc(u)  ) / 2
           =           erfc(-u)   / 2

So,

    Phi(x) = erfc( -x / sqrt(2) ) / 2

=cut
