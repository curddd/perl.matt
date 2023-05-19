sub make_primes{
	my $max = shift;

	for(my $i=2; $i<$max; $i++){
		$prime = 1;
		for(my $j=2; $j<$i; $j++){
			if( $i/$j == int($i/$j) ){
				goto out;
			}
		}
		for(my $x=1;$x<$max;$x++){
			printf("%X ",$i*$x)."\n";
		}
		print "\n";
		out:
	}
}

make_primes(0xffffffff);


