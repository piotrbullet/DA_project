data {
    int N;
    vector[N] sqft;
}

generated quantities {
    real <lower=0> alpha =  normal_rng(360000, 150000); // taken from the mean value of the prices
    real <lower=0> beta = normal_rng(210, 100); // 
    real sigma = exponential_rng(0.01);
    vector[N] price;
    for (i in 1:N) {
        price[i] = normal_rng(alpha + sqft[i]*beta, sigma);
    }

}