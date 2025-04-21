import { ActionTypes } from '../createStore';


function getErrorMessage(key, action) {
var actionType = action && action.type;
var actionName = actionType && `"${actionType.toString()}"` || 'an action';

/* This is a comment */

var unexpectedKeys = Object.keys(initialState).filter(
  key => reducerKeys.indexOf(key) < 0
 );