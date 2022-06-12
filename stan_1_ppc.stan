data {
    int N;
    real sqft[N];
}

generated quantities {
    real alpha =  normal_rng(44000, 2500);
    real beta = normal_rng(280, 150);
    real sigma = exponential_rng(0.5);
    real price[N];
    for (i in 1:N) {
        price[i] = normal_rng(alpha + sqft[i]*beta, sigma);
    }
}