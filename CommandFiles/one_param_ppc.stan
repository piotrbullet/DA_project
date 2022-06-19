data {
    int N;
    vector[N] sqft;
}

generated quantities {
    real alpha =  normal_rng(500000, 50000);
    real <lower=0> beta = normal_rng(0, 1000);
    real sigma = exponential_rng(0.01);
    vector[N] price;
    for (i in 1:N) {
        price[i] = normal_rng(alpha + sqft[i]*beta, sigma);
    }

}