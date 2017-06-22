#include <iostream>
#include <string>
#include <algorithm>

#define TEN 10
#define FIND_REMAINDER(a, b) ((a) - (((a) / (b)) * (b)))

std::int32_t RemoveDot(std::string&);
std::pair<int32_t, int32_t> FromStrNumberToIntNumber(std::string&, std::string&);
std::string Division(std::int32_t, std::int32_t, std::int32_t);

int main(int argc, char* argv[])
{
	system("chcp 1251");
	system("cls");

	std::string numb1_str;
	std::string numb2_str;
	std::int32_t precision;
	std::pair<int32_t, int32_t> numbers;
	std::int32_t number1;
	std::int32_t number2;

	std::cout << "Введіть ділене : "; std::cin >> numb1_str;
	std::cout << "Введіть дільник : "; std::cin >> numb2_str;
	std::cout << "Введіть точність обчислення (к-сть знаків після коми) : "; std::cin >> precision;
	
	numbers = FromStrNumberToIntNumber(numb1_str, numb2_str);
	number1 = numbers.first;
	number2 = numbers.second;

	std::cout << "Частка : " << Division(number1, number2, precision) << std::endl;

	system("pause");
	return 0;
}

std::int32_t RemoveDot(std::string& str)
{
	std::int32_t position_of_the_dot = str.find('.');
	std::int32_t amount_of_numbers_after_the_decimal_point = str.length() - position_of_the_dot - 1;
	str.erase(std::remove(str.begin(), str.end(), '.'), str.end());
	return amount_of_numbers_after_the_decimal_point;
}
std::pair<int32_t, int32_t> FromStrNumberToIntNumber(std::string& numb1_str, std::string& numb2_str)
{
	std::int32_t amount_of_numbers_after_the_decimal_point_numb1;
	std::int32_t amount_of_numbers_after_the_decimal_point_numb2;

	if (numb1_str.find('.') != std::string::npos)
	{
		amount_of_numbers_after_the_decimal_point_numb1 = RemoveDot(numb1_str);
	}
	else
	{
		amount_of_numbers_after_the_decimal_point_numb1 = 0;
	}
	if (numb2_str.find('.') != std::string::npos)
	{
		amount_of_numbers_after_the_decimal_point_numb2 = RemoveDot(numb2_str);
	}
	else
	{
		amount_of_numbers_after_the_decimal_point_numb2 = 0;
	}

	std::int32_t number_1 = std::stoi(numb1_str);
	std::int32_t number_2 = std::stoi(numb2_str);

	if (amount_of_numbers_after_the_decimal_point_numb1 > amount_of_numbers_after_the_decimal_point_numb2)
	{
		number_2 = number_2 * pow(TEN, (amount_of_numbers_after_the_decimal_point_numb1 - amount_of_numbers_after_the_decimal_point_numb2));
	}
	else if (amount_of_numbers_after_the_decimal_point_numb2 > amount_of_numbers_after_the_decimal_point_numb1)
	{
		number_1 = number_1 * pow(TEN, (amount_of_numbers_after_the_decimal_point_numb2 - amount_of_numbers_after_the_decimal_point_numb1));
	}

	return std::make_pair(number_1, number_2);
}
std::string Division(std::int32_t numb1, std::int32_t numb2, std::int32_t precision)
{
	std::string result = "";
	std::int32_t remainder;
	if (!(numb1 < 0 && numb2 < 0))
	{
		if (numb1 < 0 || numb2 < 0)
		{
			result.push_back('-');
		}
	}
	result += std::to_string(abs(static_cast<std::int32_t>(numb1 / numb2)));
	result.push_back('.');
	for (std::size_t i(0); i < precision; ++i)
	{
		remainder = FIND_REMAINDER(numb1, numb2);
		remainder *= TEN;
		numb1 = remainder;
		result += std::to_string(abs(static_cast<std::int32_t>(numb1 / numb2)));
	}
	return result;
}