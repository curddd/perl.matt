require "./calc.pl";
require "./div_fast.pl";

sub open_prime_file{
	print $::hey;
	my $filename = shift;
	open $::prime_file, $filename or die "CAN'T OPEN PRIME FILE";
}	

sub get_next_prime{
	my $line = <$::prime_file>;
	return $line;
}




sub factor{
	my $to_factor = shift;

	open $prime_file, $::filename or die "CAN'T OPEN PRIME FILE";

	@factored = ();

	for(my $i=0; $i<0xf; $i++){
		my $prime_to_test= <$prime_file>;
		$prime_to_test =~ s/0+//g;
print("prime $prime_to_test\n");

		($res, $rest) = fast_div($to_factor,$prime_to_test,$hex_c);

print ("here");
		for(my $j=0; $j<hex($res); $j++){
			push(@factored,$prime_to_test);
		}
		
		$to_factor = $rest;

	print "rest $rest\n";
	print "FACTORED @factored\n";

	}			

}	


$filename = "/home/gggdb/hash/32bit_primes";

factor("F5332");
	
