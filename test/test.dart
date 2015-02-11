import 'package:unittest/unittest.dart';
import 'package:mersenne/mersenne.dart';

test_gen(f, iter) {
    var n = (iter / 1000).floor();
    if (n * 1000 != iter) {
        throw "Iteration count ${iter} must be divisible by 1000";
    }
    var a = new List.filled(n, 0);
    for (var i = 0; i < iter; i += 1) {
        var q = f(n).floor();
        a[q % n] += 1;
    }
    var err = null;
    for (var i = 0; i < n; i += 1) {
        if (a[i] < 890 || a[i] > 1100) {
            err = "Index ${i} out of ${n} is outside [890,1100]: ${a[i]}";
        }
    }
    if (err != null) {
        throw err;
    }
}

main() {

    test('test', () {
        var mt = new MersenneTwister();

        mt.seed(4711);
        test_gen((range) => mt.rand(range), 100000);

        mt.seed_array([15, 9932, 11147]);
        test_gen((range) => mt.rand(range), 100000);
    });
}