data {
    int N;
    vector [N] sqft;
    vector [N] grade;
}

generated quantities {
    real alpha =  normal_rng(500000, 1000);
    real<lower=0> beta_sqft = normal_rng(0, 1000);
    real<lower=0> beta_grade = normal_rng(0, 1000);
    real sigma = exponential_rng(0.01);
    vector [N] price;
    for (i in 1:N) {
        price[i] = normal_rng(alpha + sqft[i]*beta_sqft + grade[i]*beta_grade, sigma);
    }
}