/* eslint-disable camelcase */
const responseStandard = require("../helpers/response");
const transactionModels = require("../models/transactionModels");

const topUp = async (req, res) => {
  try {
    const { id } = req.user;
    const { amount } = req.body;

    if (!amount) {
      return responseStandard(res, "This field can not be empty", {}, 400, false);
    } else if (Number(amount) < 10000) {
      return responseStandard(res, "The minimum amount is Rp10,000", {}, 400, false);
    }
    const result = await transactionModels.topUp(id, amount);
    if (result) {
      console.log(result);
      return responseStandard(res, "Balance added successfully!", {}, 200, true);
    }
  } catch (error) {
    console.log(error);
    return responseStandard(res, error.message, {}, 500, false);
  }
};

const transfer = async (req, res) => {
  try {
    const { id } = req.user;
    const { receiver_id, amount, note } = req.body;

    if (!amount) {
      return responseStandard(res, "This field can not be empty", {}, 400, false);
    } else if (Number(amount) < 10000) {
      return responseStandard(res, "The minimum amount is Rp10,000", {}, 400, false);
    }
    const result = await transactionModels.transfer(id, receiver_id, amount, note);
    if (result) {
      console.log(result);
      if (result.conflict) {
        return responseStandard(res, result.conflict, {}, 200, false);
      } else {
        return responseStandard(res, "Transfer was successful. The balance will be sent to the destination user!", {}, 200, true);
      }
    }
  } catch (error) {
    console.log(error);
    return responseStandard(res, error.message, {}, 500, false);
  }
};

module.exports = { topUp, transfer };
