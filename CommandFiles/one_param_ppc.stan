data {
    int N;
    vector[N] sqft;
}

generated quantities {
    real alpha =  lognormal_rng(0, 1);
    real beta = lognormal_rng(0, 1);
    real sigma = exponential_rng(1);
    vector[N] price;
    for (i in 1:N) {
        price[i] = normal_rng(alpha + sqft[i]*beta, sigma);
    }
}