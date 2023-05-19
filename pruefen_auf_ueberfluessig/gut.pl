use Math::BigInt;
use Crypt::Digest::SHA256 qw(sha256);
use Crypt::Digest::RIPEMD160 qw(ripemd160);


require "./1m1.pl";

sub b58_to_public {
my $address = '1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2';
#my $address = '1FeexV6bAHb8ybZjqQMjJrcCrHGW9sb6uF';
my $addr_len = length($address);


print "addr len $addr_len\n";

# Decode the Base58Check address
my $decoded = base58_decode($address);
print "decoded $decoded\n";
print "decoded len ".length($decoded)."\n";

#hex variante
my $dec_hex = from_base10($hex_c,$decoded);
print "$dec_hex ".length($dec_hex)."\n";



# get hash160 from the decoded address
my $hash160 = substr $decoded,0, -7;

print "hash160 $hash160\n";



# Add the version byte to the hash160
$hash160 = '00' . $hash160;
print "hash $hash160\n";

# Double hash the versioned hash160
my $hash = sha256(sha256(pack('H*', $hash160)));
print "hash $hash $hash160\n";

# Get the first 4 bytes of the double hash
my $checksum = substr($hash, 0, 8);

# Add the checksum to the versioned hash160 to get the full key
my $full_key = $hash160 . $checksum;
print "full_key $full_key\n";
# Convert the full key to a Math::BigInt
my $key = Math::BigInt->new($full_key);

# Convert the key to a hex string and pad with zeros
my $hex_key = sprintf('%0*x', 66, $key->as_hex);

# Get the X and Y coordinates from the hex key
my $x = substr($hex_key, 2, 64);
my $y = substr($hex_key, 66);

# Add the uncompressed prefix to the X and Y coordinates
my $uncompressed = '04' . $x . $y;

# Print the uncompressed public key
print $uncompressed . "\n";
print "???????\n\n????";
}


sub base58_encode {
    $num = shift;
    $alphabet = '123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ';
    @alphabet= split(//,$alphabet);
    $base_count = length($alphabet);
    $encoded = '';

    while ($num >= $base_count) {
        $div = $num / $base_count;
        $mod = ($num - ($base_count * int($div)));
        $encoded = $alphabet[$mod] . $encoded;
        $num = int($div);
    }

    if ($num) {
        $encoded = $alphabet[$num] . $encoded;
    }

    return $encoded;
}

sub base58_decode{
    $num = shift;
    $alphabet = '123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ';
    $len = length($num);
    $decoded = Math::BigInt->new(0x0);
    $multi = Math::BigInt->new(0x1);

    @arr = split(//,$num);
    for ($i = $len - 1; $i >= 0; $i--) {
        $decoded += $multi * index($alphabet, $arr[$i]);

        $multi = $multi * length($alphabet);
    }
    return $decoded;
}

$answer = base58_decode("hello");
print($answer."\n");
$answer = base58_encode($answer);
print($answer."\n");
$answer = base58_decode($answer);
print($answer."\n");
b58_to_public();
