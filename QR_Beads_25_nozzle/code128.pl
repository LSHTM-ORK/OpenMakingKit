#! 

use Barcode::Code128;
    $object = new Barcode::Code128;
    print "Content-Type: image/png\n\n";
    $object->png('CODE 128');
