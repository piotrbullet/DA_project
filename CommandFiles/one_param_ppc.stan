data {
    int N;
    vector[N] sqft;
}

generated quantities {
    real alpha =  normal_rng(40000, 4000);
    real beta = normal_rng(1000, 250);
    real sigma = exponential_rng(0.1);
    vector[N] price;
    for (i in 1:N) {
        price[i] = normal_rng(alpha + sqft[i]*beta, sigma);
    }

}