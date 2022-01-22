#include <stdio.h>
void add_four_floats(float[], float[], float[]);

int main() {
    float x[] = {-29.750, 244.333, 887.29, 48.1E22};
    float y[] = {29.750,  199.333, -8.29,  22.1E23};
    float out[4];
    add_four_floats(x, y, out);
    printf("%f\n%f\n%f\n%f\n", out[0], out[1], out[2], out[3]);
    return 0;
}
