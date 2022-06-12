data {
    int N;
    vector [N] sqft_living;
    vector [N] grade;
    vector [N] price;
}

generated quantities {
    real alpha =  normal_rng(44000, 2500);
    real beta_sqft = normal_rng(280, 150);
    real beta_grade = normal_rng(1, 0.5);
    real sigma = exponential_rng(0.5);
    real price[N];
    for (i in 1:N) {
        price[i] = normal_rng((alpha + sqft[i]*beta)*beta_grade, sigma);
    }
}