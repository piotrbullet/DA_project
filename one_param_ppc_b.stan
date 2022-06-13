data {
    int N;
    vector[N] sqft;
}

generated quantities {
    real alpha = normal_rng(50000, 2500);
    real beta = normal_rng(250, 60);
    real sigma = exponential_rng(0.003);
    vector[N] price;
    for (i in 1:N) {
        price[i] = normal_rng(alpha + sqft[i]*beta, sigma);
    }
}